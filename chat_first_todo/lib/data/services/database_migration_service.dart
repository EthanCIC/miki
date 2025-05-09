import 'dart:io';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:miki/data/models/todo.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

/// 數據庫遷移服務，用於處理數據庫模式變更
class DatabaseMigrationService {
  static const String _schemaVersionKey = 'isar_schema_version';
  static const String _migrationHistoryKey = 'isar_migration_history';
  static const int _currentVersion = 1; // 當前數據庫模式版本

  /// 定義支持的遷移路徑，用於確定如何從一個版本升級到另一個版本
  static final Map<String, Future<Isar> Function(String)> _migrationPaths = {
    '1:2': _migrateV1ToV2,
    // 未來可添加更多遷移路徑，例如
    // '2:3': _migrateV2ToV3,
    // '1:3': _migrateV1ToV3, // 直接從 1 跳到 3 的路徑
  };

  /// 執行數據庫遷移
  static Future<Isar> migrateDatabase() async {
    final prefs = await SharedPreferences.getInstance();
    final storedVersion = prefs.getInt(_schemaVersionKey) ?? 0;

    // 獲取 Isar 數據庫路徑
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = dir.path;

    // 如果是新安裝或數據庫版本相同，直接打開數據庫
    if (storedVersion == 0 || storedVersion == _currentVersion) {
      final isar = await _openDatabase(dbPath);
      // 保存當前版本
      await prefs.setInt(_schemaVersionKey, _currentVersion);

      // 如果是新安裝，添加初始遷移記錄
      if (storedVersion == 0) {
        await _addMigrationHistoryEntry(
            prefs, 0, _currentVersion, 'Initial installation', true);
      }

      return isar;
    }

    // 如果數據庫版本較新，可能是從較新版本降級，需要重建數據庫
    if (storedVersion > _currentVersion) {
      debugPrint('檢測到版本降級：從 $storedVersion 降級到 $_currentVersion');
      await _addMigrationHistoryEntry(prefs, storedVersion, _currentVersion,
          'Downgrade detected - rebuilding database', false);

      try {
        await _rebuildDatabase(dbPath);
        final isar = await _openDatabase(dbPath);
        await prefs.setInt(_schemaVersionKey, _currentVersion);

        // 添加降級成功記錄
        await _addMigrationHistoryEntry(prefs, storedVersion, _currentVersion,
            'Downgrade completed successfully', true);

        return isar;
      } catch (e) {
        // 降級失敗記錄
        await _addMigrationHistoryEntry(prefs, storedVersion, _currentVersion,
            'Downgrade failed: ${e.toString()}', false);
        rethrow;
      }
    }

    // 執行升級遷移策略
    Isar? isar;

    try {
      // 檢查是否需要遷移
      if (storedVersion < _currentVersion) {
        debugPrint('檢測到版本升級：從 $storedVersion 升級到 $_currentVersion');

        // 嘗試找到直接遷移路徑
        final directPathKey = '$storedVersion:$_currentVersion';

        if (_migrationPaths.containsKey(directPathKey)) {
          // 存在直接遷移路徑
          await _addMigrationHistoryEntry(prefs, storedVersion, _currentVersion,
              'Starting direct migration using path: $directPathKey', false);

          isar = await _migrationPaths[directPathKey]!(dbPath);

          await _addMigrationHistoryEntry(prefs, storedVersion, _currentVersion,
              'Direct migration completed successfully', true);
        } else {
          // 嘗試逐步遷移
          int currentDbVersion = storedVersion;
          await _addMigrationHistoryEntry(
              prefs,
              storedVersion,
              _currentVersion,
              'Starting incremental migration from $storedVersion to $_currentVersion',
              false);

          while (currentDbVersion < _currentVersion) {
            final nextVersion = _findNextVersion(currentDbVersion);

            if (nextVersion == null) {
              // 無法找到有效的遷移路徑，執行全數據備份和重建
              await _addMigrationHistoryEntry(
                  prefs,
                  currentDbVersion,
                  _currentVersion,
                  'No valid migration path found, attempting full backup and rebuild',
                  false);

              isar = await _fullBackupAndRebuild(dbPath, currentDbVersion);
              break;
            }

            final stepPathKey = '$currentDbVersion:$nextVersion';

            await _addMigrationHistoryEntry(
                prefs,
                currentDbVersion,
                nextVersion,
                'Performing incremental step using path: $stepPathKey',
                false);

            isar = await _migrationPaths[stepPathKey]!(dbPath);
            currentDbVersion = nextVersion;

            await _addMigrationHistoryEntry(
                prefs,
                currentDbVersion - 1,
                currentDbVersion,
                'Incremental step completed successfully',
                true);
          }

          await _addMigrationHistoryEntry(prefs, storedVersion, _currentVersion,
              'Incremental migration completed successfully', true);
        }
      }

      // 保存當前版本
      await prefs.setInt(_schemaVersionKey, _currentVersion);
      return isar ?? await _openDatabase(dbPath);
    } catch (e) {
      // 遷移失敗，記錄並嘗試恢復
      final error = '數據庫遷移失敗: $e';
      debugPrint(error);

      await _addMigrationHistoryEntry(prefs, storedVersion, _currentVersion,
          'Migration failed: ${e.toString()}', false);

      try {
        // 嘗試執行備份和重建
        await _addMigrationHistoryEntry(prefs, storedVersion, _currentVersion,
            'Attempting recovery through full backup and rebuild', false);

        isar = await _fullBackupAndRebuild(dbPath, storedVersion);

        await _addMigrationHistoryEntry(
            prefs, storedVersion, _currentVersion, 'Recovery succeeded', true);

        await prefs.setInt(_schemaVersionKey, _currentVersion);
        return isar;
      } catch (recoveryError) {
        // 恢復也失敗，最後嘗試清潔重建
        final recoveryErrorMsg = '恢復失敗: $recoveryError';
        debugPrint(recoveryErrorMsg);

        await _addMigrationHistoryEntry(
            prefs,
            storedVersion,
            _currentVersion,
            'Recovery failed: ${recoveryError.toString()}. Attempting clean rebuild.',
            false);

        await _rebuildDatabase(dbPath);
        final cleanIsar = await _openDatabase(dbPath);

        await _addMigrationHistoryEntry(prefs, storedVersion, _currentVersion,
            'Clean rebuild completed (all data lost)', true);

        await prefs.setInt(_schemaVersionKey, _currentVersion);
        return cleanIsar;
      }
    }
  }

  /// 查找下一個可用的版本
  static int? _findNextVersion(int currentVersion) {
    final possibleNextVersions = _migrationPaths.keys
        .where((key) => key.startsWith('$currentVersion:'))
        .map((key) => int.parse(key.split(':')[1]))
        .toList();

    if (possibleNextVersions.isEmpty) {
      return null;
    }

    // 返回最接近的下一個版本
    possibleNextVersions.sort();
    return possibleNextVersions.first;
  }

  /// 添加遷移歷史記錄
  static Future<void> _addMigrationHistoryEntry(SharedPreferences prefs,
      int fromVersion, int toVersion, String message, bool success) async {
    final timestamp = DateTime.now().toIso8601String();
    final historyList = prefs.getStringList(_migrationHistoryKey) ?? [];

    final entry = jsonEncode({
      'timestamp': timestamp,
      'fromVersion': fromVersion,
      'toVersion': toVersion,
      'message': message,
      'success': success
    });

    historyList.add(entry);

    // 保持歷史記錄限制在合理範圍內，只保留最近的 20 條記錄
    if (historyList.length > 20) {
      historyList.removeRange(0, historyList.length - 20);
    }

    await prefs.setStringList(_migrationHistoryKey, historyList);
  }

  /// 完全備份和重建
  static Future<Isar> _fullBackupAndRebuild(
      String dbPath, int fromVersion) async {
    // 備份所有數據
    final backupData = await _backupAllData(dbPath, fromVersion);

    // 重建數據庫
    await _rebuildDatabase(dbPath);

    // 打開新數據庫
    final newDb = await _openDatabase(dbPath);

    // 恢復數據
    if (backupData.isNotEmpty) {
      await _restoreData(newDb, backupData);
    }

    return newDb;
  }

  /// 備份所有數據
  static Future<Map<String, List<Map<String, dynamic>>>> _backupAllData(
      String dbPath, int fromVersion) async {
    final backupData = <String, List<Map<String, dynamic>>>{};

    try {
      final db = await Isar.open(
        [TodoSchema],
        directory: dbPath,
      );

      // 備份所有 Todo 項目
      final todos = await db.todos.where().findAll();
      backupData['todos'] = todos.map((todo) => todo.toJson()).toList();

      // 未來可以在這裡添加其他模型類型的備份

      await db.close();
    } catch (e) {
      debugPrint('備份數據時發生錯誤: $e');
      // 返回空映射，表示備份失敗
    }

    return backupData;
  }

  /// 恢復數據
  static Future<void> _restoreData(
      Isar db, Map<String, List<Map<String, dynamic>>> backupData) async {
    await db.writeTxn(() async {
      // 恢復 Todo 項目
      if (backupData.containsKey('todos')) {
        for (var todoJson in backupData['todos']!) {
          final todo = Todo.fromJson(todoJson);
          await db.todos.put(todo);
        }
      }

      // 未來可以在這裡添加其他模型類型的恢復
    });
  }

  /// 打開數據庫
  static Future<Isar> _openDatabase(String dbPath) async {
    return await Isar.open(
      [TodoSchema],
      // 未來可以在這裡添加其他模型的 Schema
      directory: dbPath,
    );
  }

  /// 重建數據庫
  static Future<void> _rebuildDatabase(String dbPath) async {
    try {
      // 刪除現有數據庫文件
      final file = File(path.join(dbPath, 'isar.isar'));
      if (await file.exists()) {
        await file.delete();
      }

      // 刪除鎖文件
      final lockFile = File(path.join(dbPath, 'isar.isar.lock'));
      if (await lockFile.exists()) {
        await lockFile.delete();
      }

      // 確保所有連接關閉
      try {
        // 獲取並關閉當前可能開啟的 Isar 實例
        final currentIsar = await _openDatabase(dbPath);
        await currentIsar.close();
      } catch (e) {
        // 忽略錯誤，可能數據庫已經關閉
        debugPrint('關閉現有數據庫時出錯：$e');
      }
    } catch (e) {
      debugPrint('重建數據庫時出錯：$e');
      rethrow;
    }
  }

  /// 從版本 1 遷移到版本 2
  static Future<Isar> _migrateV1ToV2(String dbPath) async {
    // 打開舊版本數據庫
    final oldDb = await Isar.open(
      [TodoSchema],
      directory: dbPath,
    );

    // 導出舊數據
    final todos = await oldDb.todos.where().findAll();
    final todosBackup = todos.map((todo) => todo.toJson()).toList();

    // 關閉並刪除舊數據庫
    await oldDb.close();
    await _rebuildDatabase(dbPath);

    // 打開新版本數據庫
    final newDb = await _openDatabase(dbPath);

    // 導入備份的數據，必要時進行數據轉換
    await newDb.writeTxn(() async {
      for (var todoJson in todosBackup) {
        // 在這裡可以添加版本 1 到版本 2 所需的任何數據轉換邏輯
        // 例如，如果版本 2 添加了新欄位：
        // todoJson['newField'] = defaultValue;

        final todo = Todo.fromJson(todoJson);
        await newDb.todos.put(todo);
      }
    });

    return newDb;
  }

  /// 檢查是否需要遷移
  static Future<bool> needsMigration() async {
    final prefs = await SharedPreferences.getInstance();
    final storedVersion = prefs.getInt(_schemaVersionKey) ?? 0;
    return storedVersion < _currentVersion;
  }

  /// 獲取數據庫版本
  static Future<int> getDatabaseVersion() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_schemaVersionKey) ?? 0;
  }

  /// 獲取遷移歷史記錄
  static Future<List<Map<String, dynamic>>> getMigrationHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyList = prefs.getStringList(_migrationHistoryKey) ?? [];

    return historyList
        .map((entry) => jsonDecode(entry) as Map<String, dynamic>)
        .toList()
        .reversed
        .toList(); // 返回最新的記錄在前面
  }

  /// 清除遷移歷史記錄
  static Future<void> clearMigrationHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_migrationHistoryKey);
  }

  /// 重置數據庫（測試用）
  static Future<void> resetDatabase() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_schemaVersionKey);

    final dir = await getApplicationDocumentsDirectory();
    final dbPath = dir.path;

    await _rebuildDatabase(dbPath);
  }
}
