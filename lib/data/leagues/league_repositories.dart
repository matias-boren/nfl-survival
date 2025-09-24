import 'package:nfl_survival/data/models/league.dart';
import 'package:nfl_survival/data/models/user.dart';

abstract class LeagueRepository {
  Future<League> createLeague(League draft);
  Future<List<League>> listLeaguesForUser(String userId);
  Future<League> getLeague(String leagueId);
  Future<void> joinLeagueByCode(String inviteCode);
  Future<void> joinPublicLeague(String leagueId);
  Stream<List<User>> leagueMembers(String leagueId);
}
