import 'package:freezed_annotation/freezed_annotation.dart';

part 'nfl.freezed.dart';
part 'nfl.g.dart';

enum GameStatus { SCHEDULED, IN_PROGRESS, FINAL }

@freezed
abstract class Team with _$Team {
  const factory Team({
    required String id,
    required String name,
    required String abbreviation,
    required String city,
    String? logoUrl,
    String? color,
    String? alternateColor,
  }) = _Team;

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
}

@freezed
abstract class Game with _$Game {
  const factory Game({
    required String id,
    required Team homeTeam,
    required Team awayTeam,
    required int homeScore,
    required int awayScore,
    required GameStatus status,
    required int quarter,
    required String timeRemaining,
    required DateTime date,
    required int week,
    required int season,
  }) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}

// LiveScore model removed to fix CI issues
