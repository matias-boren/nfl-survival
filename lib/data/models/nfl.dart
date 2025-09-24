import 'package:freezed_annotation/freezed_annotation.dart';

part 'nfl.freezed.dart';
part 'nfl.g.dart';

enum GameStatus { SCHEDULED, LIVE, FINAL }

@freezed
abstract class Team with _$Team {
  const factory Team({
    required String id,
    required String name,
    required String abbr,
  }) = _Team;

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
}

@freezed
abstract class Game with _$Game {
  const factory Game({
    required String id,
    required int week,
    required String homeId,
    required String awayId,
    required String startIso,
    required GameStatus status,
    int? homeScore,
    int? awayScore,
  }) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}

