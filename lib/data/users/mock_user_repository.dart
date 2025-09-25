import 'dart:math';
import 'package:nfl_survival/data/users/user_repositories.dart';
import 'package:nfl_survival/data/models/user.dart';

class MockUserRepository implements UserRepository {
  // Mock users database - will be populated dynamically
  final List<User> _users = [];
  
  // Sample display names for generating realistic user data
  final List<String> _sampleNames = [
    'John Smith', 'Sarah Johnson', 'Mike Wilson', 'Emma Davis',
    'Alex Brown', 'Lisa Garcia', 'David Miller', 'Maria Rodriguez',
    'Chris Anderson', 'Jennifer Taylor', 'Robert Thomas', 'Amanda White',
    'James Jackson', 'Michelle Harris', 'Daniel Martin', 'Ashley Thompson'
  ];
  
  final List<String> _sampleTeams = [
    'Kansas City Chiefs', 'Buffalo Bills', 'Green Bay Packers', 'Dallas Cowboys',
    'New England Patriots', 'Pittsburgh Steelers', 'San Francisco 49ers', 'Seattle Seahawks',
    'Denver Broncos', 'Las Vegas Raiders', 'Miami Dolphins', 'Baltimore Ravens',
    'Cincinnati Bengals', 'Cleveland Browns', 'Houston Texans', 'Indianapolis Colts'
  ];

  @override
  Future<User?> getUserById(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    
    // First, try to find existing user
    try {
      return _users.firstWhere((user) => user.id == userId);
    } catch (e) {
      // If user doesn't exist, create a mock user for this ID
      final user = _createMockUser(userId);
      _users.add(user);
      return user;
    }
  }
  
  User _createMockUser(String userId) {
    final random = Random();
    final name = _sampleNames[random.nextInt(_sampleNames.length)];
    final team = _sampleTeams[random.nextInt(_sampleTeams.length)];
    
    return User(
      id: userId,
      displayName: name,
      email: '${name.toLowerCase().replaceAll(' ', '.')}@example.com',
      isPremium: random.nextBool(),
      joinedLeagueIds: [],
      favoriteTeam: team,
    );
  }

  @override
  Future<List<User>> getUsersByIds(List<String> userIds) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    
    return _users.where((user) => userIds.contains(user.id)).toList();
  }

  // Helper method to get a random user (for testing)
  User getRandomUser() {
    final random = Random();
    return _users[random.nextInt(_users.length)];
  }
}
