// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => _ChatMessage(
  id: json['id'] as String,
  leagueId: json['leagueId'] as String,
  userId: json['userId'] as String,
  userName: json['userName'] as String,
  message: json['message'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  isSystemMessage: json['isSystemMessage'] as bool? ?? false,
);

Map<String, dynamic> _$ChatMessageToJson(_ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'leagueId': instance.leagueId,
      'userId': instance.userId,
      'userName': instance.userName,
      'message': instance.message,
      'createdAt': instance.createdAt.toIso8601String(),
      'isSystemMessage': instance.isSystemMessage,
    };
