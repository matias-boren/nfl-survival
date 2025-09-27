import 'package:nfl_survival/data/models/league.dart';
import 'package:nfl_survival/data/models/user.dart';

abstract class LeagueRepository {
  Future<League> createLeague(League draft);
  Future<List<League>> listLeaguesForUser(String userId);
  Future<League> getLeague(String leagueId);
  Future<void> joinLeagueByCode(String inviteCode);
  Future<void> joinPublicLeague(String leagueId);
  Future<void> joinLeague(String leagueId, String userId);
  Future<void> leaveLeague(String leagueId, String userId);
  Future<List<League>> getPublicLeagues();
  Future<List<League>> listLeagues([String? userId]);
  Stream<List<User>> leagueMembers(String leagueId);
  Future<void> updateLeague(League league);
  Future<void> deleteLeague(String leagueId);
}
