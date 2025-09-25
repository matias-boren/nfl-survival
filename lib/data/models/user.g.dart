// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String,
  displayName: json['displayName'] as String,
  email: json['email'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  isPremium: json['isPremium'] as bool,
  joinedLeagueIds: (json['joinedLeagueIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  favoriteTeam: json['favoriteTeam'] as String?,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'displayName': instance.displayName,
  'email': instance.email,
  'avatarUrl': instance.avatarUrl,
  'isPremium': instance.isPremium,
  'joinedLeagueIds': instance.joinedLeagueIds,
  'favoriteTeam': instance.favoriteTeam,
};
