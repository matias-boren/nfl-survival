import 'package:nfl_survival/data/models/user.dart';

abstract class UserRepository {
  // Get user by ID
  Future<User?> getUserById(String userId);
  
  // Get multiple users by IDs
  Future<List<User>> getUsersByIds(List<String> userIds);
}

