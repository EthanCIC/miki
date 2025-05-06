// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetChatMessageCollection on Isar {
  IsarCollection<ChatMessage> get chatMessages => this.collection();
}

const ChatMessageSchema = CollectionSchema(
  name: r'ChatMessage',
  id: 35366979330584919,
  properties: {
    r'attachmentUrl': PropertySchema(
      id: 0,
      name: r'attachmentUrl',
      type: IsarType.string,
    ),
    r'content': PropertySchema(
      id: 1,
      name: r'content',
      type: IsarType.string,
    ),
    r'hasAttachment': PropertySchema(
      id: 2,
      name: r'hasAttachment',
      type: IsarType.bool,
    ),
    r'isAssistantMessage': PropertySchema(
      id: 3,
      name: r'isAssistantMessage',
      type: IsarType.bool,
    ),
    r'isRead': PropertySchema(
      id: 4,
      name: r'isRead',
      type: IsarType.bool,
    ),
    r'isSystemMessage': PropertySchema(
      id: 5,
      name: r'isSystemMessage',
      type: IsarType.bool,
    ),
    r'isTodoRelated': PropertySchema(
      id: 6,
      name: r'isTodoRelated',
      type: IsarType.bool,
    ),
    r'isUserMessage': PropertySchema(
      id: 7,
      name: r'isUserMessage',
      type: IsarType.bool,
    ),
    r'needsAttention': PropertySchema(
      id: 8,
      name: r'needsAttention',
      type: IsarType.bool,
    ),
    r'sender': PropertySchema(
      id: 9,
      name: r'sender',
      type: IsarType.byte,
      enumMap: _ChatMessagesenderEnumValueMap,
    ),
    r'timeDisplay': PropertySchema(
      id: 10,
      name: r'timeDisplay',
      type: IsarType.string,
    ),
    r'timestamp': PropertySchema(
      id: 11,
      name: r'timestamp',
      type: IsarType.dateTime,
    ),
    r'todoId': PropertySchema(
      id: 12,
      name: r'todoId',
      type: IsarType.long,
    ),
    r'type': PropertySchema(
      id: 13,
      name: r'type',
      type: IsarType.byte,
      enumMap: _ChatMessagetypeEnumValueMap,
    )
  },
  estimateSize: _chatMessageEstimateSize,
  serialize: _chatMessageSerialize,
  deserialize: _chatMessageDeserialize,
  deserializeProp: _chatMessageDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _chatMessageGetId,
  getLinks: _chatMessageGetLinks,
  attach: _chatMessageAttach,
  version: '3.1.0+1',
);

int _chatMessageEstimateSize(
  ChatMessage object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.attachmentUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.content.length * 3;
  bytesCount += 3 + object.timeDisplay.length * 3;
  return bytesCount;
}

void _chatMessageSerialize(
  ChatMessage object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.attachmentUrl);
  writer.writeString(offsets[1], object.content);
  writer.writeBool(offsets[2], object.hasAttachment);
  writer.writeBool(offsets[3], object.isAssistantMessage);
  writer.writeBool(offsets[4], object.isRead);
  writer.writeBool(offsets[5], object.isSystemMessage);
  writer.writeBool(offsets[6], object.isTodoRelated);
  writer.writeBool(offsets[7], object.isUserMessage);
  writer.writeBool(offsets[8], object.needsAttention);
  writer.writeByte(offsets[9], object.sender.index);
  writer.writeString(offsets[10], object.timeDisplay);
  writer.writeDateTime(offsets[11], object.timestamp);
  writer.writeLong(offsets[12], object.todoId);
  writer.writeByte(offsets[13], object.type.index);
}

ChatMessage _chatMessageDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ChatMessage(
    attachmentUrl: reader.readStringOrNull(offsets[0]),
    content: reader.readString(offsets[1]),
    needsAttention: reader.readBoolOrNull(offsets[8]) ?? false,
    sender: _ChatMessagesenderValueEnumMap[reader.readByteOrNull(offsets[9])] ??
        SenderType.user,
    todoId: reader.readLongOrNull(offsets[12]),
    type: _ChatMessagetypeValueEnumMap[reader.readByteOrNull(offsets[13])] ??
        MessageType.text,
  );
  object.hasAttachment = reader.readBool(offsets[2]);
  object.id = id;
  object.isRead = reader.readBool(offsets[4]);
  object.timestamp = reader.readDateTime(offsets[11]);
  return object;
}

P _chatMessageDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 9:
      return (_ChatMessagesenderValueEnumMap[reader.readByteOrNull(offset)] ??
          SenderType.user) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readDateTime(offset)) as P;
    case 12:
      return (reader.readLongOrNull(offset)) as P;
    case 13:
      return (_ChatMessagetypeValueEnumMap[reader.readByteOrNull(offset)] ??
          MessageType.text) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ChatMessagesenderEnumValueMap = {
  'user': 0,
  'assistant': 1,
  'system': 2,
};
const _ChatMessagesenderValueEnumMap = {
  0: SenderType.user,
  1: SenderType.assistant,
  2: SenderType.system,
};
const _ChatMessagetypeEnumValueMap = {
  'text': 0,
  'image': 1,
  'system': 2,
  'todoReference': 3,
};
const _ChatMessagetypeValueEnumMap = {
  0: MessageType.text,
  1: MessageType.image,
  2: MessageType.system,
  3: MessageType.todoReference,
};

Id _chatMessageGetId(ChatMessage object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _chatMessageGetLinks(ChatMessage object) {
  return [];
}

void _chatMessageAttach(
    IsarCollection<dynamic> col, Id id, ChatMessage object) {
  object.id = id;
}

extension ChatMessageQueryWhereSort
    on QueryBuilder<ChatMessage, ChatMessage, QWhere> {
  QueryBuilder<ChatMessage, ChatMessage, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ChatMessageQueryWhere
    on QueryBuilder<ChatMessage, ChatMessage, QWhereClause> {
  QueryBuilder<ChatMessage, ChatMessage, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ChatMessageQueryFilter
    on QueryBuilder<ChatMessage, ChatMessage, QFilterCondition> {
  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      attachmentUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'attachmentUrl',
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      attachmentUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'attachmentUrl',
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      attachmentUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'attachmentUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      attachmentUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'attachmentUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      attachmentUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'attachmentUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      attachmentUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'attachmentUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      attachmentUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'attachmentUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      attachmentUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'attachmentUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      attachmentUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'attachmentUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      attachmentUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'attachmentUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      attachmentUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'attachmentUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      attachmentUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'attachmentUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> contentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      contentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> contentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> contentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'content',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      contentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> contentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> contentContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> contentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'content',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      hasAttachmentEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasAttachment',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      isAssistantMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isAssistantMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> isReadEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRead',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      isSystemMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSystemMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      isTodoRelatedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isTodoRelated',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      isUserMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isUserMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      needsAttentionEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'needsAttention',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> senderEqualTo(
      SenderType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sender',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      senderGreaterThan(
    SenderType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sender',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> senderLessThan(
    SenderType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sender',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> senderBetween(
    SenderType lower,
    SenderType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sender',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      timeDisplayEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      timeDisplayGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      timeDisplayLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      timeDisplayBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeDisplay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      timeDisplayStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'timeDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      timeDisplayEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'timeDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      timeDisplayContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'timeDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      timeDisplayMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'timeDisplay',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      timeDisplayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeDisplay',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      timeDisplayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'timeDisplay',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> todoIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'todoId',
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      todoIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'todoId',
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> todoIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'todoId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      todoIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'todoId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> todoIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'todoId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> todoIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'todoId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> typeEqualTo(
      MessageType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> typeGreaterThan(
    MessageType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> typeLessThan(
    MessageType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> typeBetween(
    MessageType lower,
    MessageType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ChatMessageQueryObject
    on QueryBuilder<ChatMessage, ChatMessage, QFilterCondition> {}

extension ChatMessageQueryLinks
    on QueryBuilder<ChatMessage, ChatMessage, QFilterCondition> {}

extension ChatMessageQuerySortBy
    on QueryBuilder<ChatMessage, ChatMessage, QSortBy> {
  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByAttachmentUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attachmentUrl', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      sortByAttachmentUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attachmentUrl', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByHasAttachment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasAttachment', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      sortByHasAttachmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasAttachment', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      sortByIsAssistantMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAssistantMessage', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      sortByIsAssistantMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAssistantMessage', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByIsRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByIsReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByIsSystemMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystemMessage', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      sortByIsSystemMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystemMessage', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByIsTodoRelated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTodoRelated', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      sortByIsTodoRelatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTodoRelated', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByIsUserMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUserMessage', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      sortByIsUserMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUserMessage', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByNeedsAttention() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsAttention', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      sortByNeedsAttentionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsAttention', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortBySender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sender', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortBySenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sender', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByTimeDisplay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeDisplay', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByTimeDisplayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeDisplay', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByTodoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'todoId', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByTodoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'todoId', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension ChatMessageQuerySortThenBy
    on QueryBuilder<ChatMessage, ChatMessage, QSortThenBy> {
  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByAttachmentUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attachmentUrl', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      thenByAttachmentUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attachmentUrl', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByHasAttachment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasAttachment', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      thenByHasAttachmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasAttachment', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      thenByIsAssistantMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAssistantMessage', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      thenByIsAssistantMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAssistantMessage', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByIsRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByIsReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByIsSystemMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystemMessage', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      thenByIsSystemMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystemMessage', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByIsTodoRelated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTodoRelated', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      thenByIsTodoRelatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTodoRelated', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByIsUserMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUserMessage', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      thenByIsUserMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUserMessage', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByNeedsAttention() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsAttention', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      thenByNeedsAttentionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsAttention', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenBySender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sender', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenBySenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sender', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByTimeDisplay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeDisplay', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByTimeDisplayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeDisplay', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByTodoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'todoId', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByTodoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'todoId', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension ChatMessageQueryWhereDistinct
    on QueryBuilder<ChatMessage, ChatMessage, QDistinct> {
  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByAttachmentUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'attachmentUrl',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'content', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByHasAttachment() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasAttachment');
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct>
      distinctByIsAssistantMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isAssistantMessage');
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByIsRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRead');
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct>
      distinctByIsSystemMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSystemMessage');
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByIsTodoRelated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isTodoRelated');
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByIsUserMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isUserMessage');
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByNeedsAttention() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'needsAttention');
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctBySender() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sender');
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByTimeDisplay(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeDisplay', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByTodoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'todoId');
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }
}

extension ChatMessageQueryProperty
    on QueryBuilder<ChatMessage, ChatMessage, QQueryProperty> {
  QueryBuilder<ChatMessage, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ChatMessage, String?, QQueryOperations> attachmentUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'attachmentUrl');
    });
  }

  QueryBuilder<ChatMessage, String, QQueryOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }

  QueryBuilder<ChatMessage, bool, QQueryOperations> hasAttachmentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasAttachment');
    });
  }

  QueryBuilder<ChatMessage, bool, QQueryOperations>
      isAssistantMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isAssistantMessage');
    });
  }

  QueryBuilder<ChatMessage, bool, QQueryOperations> isReadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRead');
    });
  }

  QueryBuilder<ChatMessage, bool, QQueryOperations> isSystemMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSystemMessage');
    });
  }

  QueryBuilder<ChatMessage, bool, QQueryOperations> isTodoRelatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isTodoRelated');
    });
  }

  QueryBuilder<ChatMessage, bool, QQueryOperations> isUserMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isUserMessage');
    });
  }

  QueryBuilder<ChatMessage, bool, QQueryOperations> needsAttentionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'needsAttention');
    });
  }

  QueryBuilder<ChatMessage, SenderType, QQueryOperations> senderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sender');
    });
  }

  QueryBuilder<ChatMessage, String, QQueryOperations> timeDisplayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeDisplay');
    });
  }

  QueryBuilder<ChatMessage, DateTime, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }

  QueryBuilder<ChatMessage, int?, QQueryOperations> todoIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'todoId');
    });
  }

  QueryBuilder<ChatMessage, MessageType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
