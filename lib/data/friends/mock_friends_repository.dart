import 'package:nfl_survival/data/friends/friends_repositories.dart';
import 'package:nfl_survival/data/models/user.dart';

class MockFriendsRepository implements FriendsRepository {
  @override
  Future<List<User>> listFriends(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      const User(
        id: 'friend1',
        displayName: 'Friend One',
        isPremium: false,
        joinedLeagueIds: [],
      ),
      const User(
        id: 'friend2',
        displayName: 'Friend Two',
        isPremium: true,
        joinedLeagueIds: [],
      ),
    ];
  }

  @override
  Future<void> sendFriendRequest(String fromUserId, String toUserId) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<void> acceptFriendRequest(String fromUserId, String toUserId) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
