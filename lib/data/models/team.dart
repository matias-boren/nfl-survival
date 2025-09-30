import 'package:freezed_annotation/freezed_annotation.dart';

part 'team.freezed.dart';
part 'team.g.dart';

@freezed
abstract class Team with _$Team {
  const factory Team({
    required String id,
    required String espnTeamId,
    required String name,
    required String abbreviation,
    required String city,
    required String conference,
    required String division,
    String? logoUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Team;

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
}

@freezed
abstract class TeamRecord with _$TeamRecord {
  const factory TeamRecord({
    required String id,
    required String teamId,
    required int season,
    required int week,
    required int wins,
    required int losses,
    required int ties,
    required DateTime lastUpdated,
  }) = _TeamRecord;

  factory TeamRecord.fromJson(Map<String, dynamic> json) => _$TeamRecordFromJson(json);
}

@freezed
abstract class TeamWithRecord with _$TeamWithRecord {
  const factory TeamWithRecord({
    required Team team,
    TeamRecord? record,
  }) = _TeamWithRecord;

  factory TeamWithRecord.fromJson(Map<String, dynamic> json) => _$TeamWithRecordFromJson(json);
}
