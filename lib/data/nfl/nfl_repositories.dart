import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../../data/models/nfl.dart';

abstract class NflDataRepository {
  Future<List<int>> listWeeks(int season);
  Future<List<Game>> listGames(int season, int week);
  Future<List<Team>> listTeams(int season);
  Future<Game> getGame(String gameId);
}

class MockNflDataRepository implements NflDataRepository {
  @override
  Future<Game> getGame(String gameId) async {
    final games = await listGames(2025, 1);
    return games.firstWhere((g) => g.id == gameId);
  }

  @override
  Future<List<Game>> listGames(int season, int week) async {
    final jsonStr = await rootBundle.loadString('assets/mock/schedule_${season}_week_${week}.json');
    final data = json.decode(jsonStr) as List;
    return data.map((e) => Game.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  @override
  Future<List<Team>> listTeams(int season) async {
    final jsonStr = await rootBundle.loadString('assets/mock/teams.json');
    final data = json.decode(jsonStr) as List;
    return data.map((e) => Team.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  @override
  Future<List<int>> listWeeks(int season) async {
    return List.generate(18, (i) => i + 1);
  }
}

