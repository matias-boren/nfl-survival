import 'package:nfl_survival/data/models/user.dart';

abstract class FriendsRepository {
  Future<List<User>> listFriends(String userId);
  Future<void> sendFriendRequest(String fromUserId, String toUserId);
  Future<void> acceptFriendRequest(String fromUserId, String toUserId);
}
