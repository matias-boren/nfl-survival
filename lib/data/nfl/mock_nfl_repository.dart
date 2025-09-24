import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nfl_survival/data/models/nfl.dart';
import 'package:nfl_survival/data/nfl/nfl_repositories.dart';

class MockNflDataRepository implements NflDataRepository {
  @override
  Future<List<int>> listWeeks(int season) async {
    return List<int>.generate(18, (index) => index + 1);
  }

  @override
  Future<List<Game>> listGames(int season, int week) async {
    final String response = await rootBundle.loadString('assets/mock/schedule_2025_week_1.json');
    final data = await json.decode(response) as List;
    return data.map((json) => Game.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<Team>> listTeams(int season) async {
    final String response = await rootBundle.loadString('assets/mock/teams.json');
    final data = await json.decode(response) as List;
    return data.map((json) => Team.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<Game> getGame(String gameId) async {
    final games = await listGames(2025, 1);
    return games.firstWhere((game) => game.id == gameId);
  }
}
