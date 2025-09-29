import 'package:freezed_annotation/freezed_annotation.dart';

part 'league.freezed.dart';
part 'league.g.dart';

enum LeagueVisibility { PUBLIC, PRIVATE }

@freezed
abstract class LeagueSettings with _$LeagueSettings {
  const factory LeagueSettings({
    required int maxLosses,
    required bool allowTeamReuse,
    required bool autoEliminateOnNoPick,
  }) = _LeagueSettings;

  factory LeagueSettings.fromJson(Map<String, dynamic> json) =>
      _$LeagueSettingsFromJson(json);
}

@freezed
abstract class League with _$League {
  const factory League({
    required String id,
    required String name,
    required String ownerId,
    required LeagueVisibility visibility,
    required LeagueSettings settings,
    required int season,
    required String createdAtIso,
    required List<String> memberIds,
    String? inviteCode,
    @Default({}) Map<String, int> memberPoints, // User ID -> Points
  }) = _League;

  factory League.fromJson(Map<String, dynamic> json) => _$LeagueFromJson(json);
}
