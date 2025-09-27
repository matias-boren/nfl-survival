import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nfl_survival/app/providers.dart';
import 'package:nfl_survival/data/billing/mock_billing_repository.dart';
import 'package:nfl_survival/data/auth/supabase_auth_repository.dart';
import 'package:nfl_survival/widgets/app_scaffold.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepo = ref.read(authRepositoryProvider);
    final billingRepo = ref.read(billingRepositoryProvider);
    final isPremium = ref.watch(premiumStatusProvider);
    final currentUser = ref.watch(currentUserProvider);

    return AppScaffold(
      appBar: AppBar(title: const Text('Settings')),
      child: ListView(
        children: [
          // Profile Section
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Profile',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          ListTile(
            title: const Text('Edit Profile'),
            subtitle: Text('Display Name: ${currentUser?.displayName ?? 'Not set'}\nFavorite Team: ${currentUser?.favoriteTeam ?? 'Not set'}\nEmail: ${currentUser?.email ?? 'Not set'}'),
            leading: const Icon(Icons.person),
            onTap: () => _showEditProfileDialog(context, ref, currentUser),
          ),
          const Divider(),
          
          // Account Section
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Account',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          ListTile(
            title: const Text('Refresh User Data'),
            subtitle: const Text('Reload premium status and profile data'),
            leading: const Icon(Icons.refresh),
            onTap: () async {
              if (authRepo is SupabaseAuthRepository) {
                await authRepo.refreshCurrentUser();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('User data refreshed!')),
                  );
                }
              }
            },
          ),
          ListTile(
            title: const Text('Sign Out'),
            leading: const Icon(Icons.logout),
            onTap: () async {
              await authRepo.signOut();
              ref.invalidate(currentUserProvider);
              context.go('/signin'); // Redirect to sign-in after sign out
            },
          ),
          ListTile(
            title: const Text('Restore Purchases'),
            onTap: () async {
              await billingRepo.restorePurchases();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Purchases restored!')),
              );
            },
          ),
          if (!isPremium)
            ListTile(
              title: const Text('Go Premium'),
              onTap: () => context.go('/paywall'),
            ),
          
          const Divider(),
          
          // Admin Section (for premium users or testing)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'System Status',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          ListTile(
            title: const Text('Weekly Data Refresh Status'),
            subtitle: const Text('View automated processing status'),
            leading: const Icon(Icons.schedule),
            onTap: () => _showWeeklyRefreshStatus(context, ref),
          ),
          
        ],
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, WidgetRef ref, currentUser) {
    final displayNameController = TextEditingController(text: currentUser?.displayName ?? '');
    String? selectedFavoriteTeam = currentUser?.favoriteTeam ?? 'Kansas City Chiefs'; // Default or from user data
    
    // NFL Teams list (same as in sign-in screen)
    const List<String> nflTeams = [
      'Arizona Cardinals',
      'Atlanta Falcons',
      'Baltimore Ravens',
      'Buffalo Bills',
      'Carolina Panthers',
      'Chicago Bears',
      'Cincinnati Bengals',
      'Cleveland Browns',
      'Dallas Cowboys',
      'Denver Broncos',
      'Detroit Lions',
      'Green Bay Packers',
      'Houston Texans',
      'Indianapolis Colts',
      'Jacksonville Jaguars',
      'Kansas City Chiefs',
      'Las Vegas Raiders',
      'Los Angeles Chargers',
      'Los Angeles Rams',
      'Miami Dolphins',
      'Minnesota Vikings',
      'New England Patriots',
      'New Orleans Saints',
      'New York Giants',
      'New York Jets',
      'Philadelphia Eagles',
      'Pittsburgh Steelers',
      'San Francisco 49ers',
      'Seattle Seahawks',
      'Tampa Bay Buccaneers',
      'Tennessee Titans',
      'Washington Commanders',
    ];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: displayNameController,
                decoration: const InputDecoration(
                  labelText: 'Display Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedFavoriteTeam,
                decoration: const InputDecoration(
                  labelText: 'Favorite NFL Team',
                  prefixIcon: Icon(Icons.sports),
                  border: OutlineInputBorder(),
                ),
                items: nflTeams.map((team) {
                  return DropdownMenuItem<String>(
                    value: team,
                    child: Text(team),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedFavoriteTeam = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (displayNameController.text.trim().isNotEmpty && selectedFavoriteTeam != null) {
                  try {
                    // Show loading state
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Updating profile...'),
                        backgroundColor: Colors.blue,
                      ),
                    );

                    // Update user profile
                    final updatedUser = await ref.read(authRepositoryProvider).updateUser(
                      displayName: displayNameController.text.trim(),
                      favoriteTeam: selectedFavoriteTeam,
                    );

                    // Update the current user in the provider
                    ref.read(currentUserProvider.notifier).state = updatedUser;

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profile updated successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.of(context).pop();
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to update profile: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in all fields'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _showWeeklyRefreshStatus(BuildContext context, WidgetRef ref) {
    final weeklyRefreshService = ref.read(weeklyDataRefreshServiceProvider);
    final status = weeklyRefreshService.getStatus();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Weekly Data Refresh Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusRow('Service Running', status['isRunning'] ? 'Active' : 'Inactive', status['isRunning']),
            _buildStatusRow('Currently Processing', status['isProcessing'] ? 'Yes' : 'No', status['isProcessing']),
            _buildStatusRow('Processing Week', status['currentProcessingWeek']?.toString() ?? 'None', status['currentProcessingWeek'] != null),
            _buildStatusRow('Check Timer', status['nextCheckTime'] ?? 'Inactive', status['nextCheckTime'] == 'Active'),
            _buildStatusRow('Refresh Timer', status['nextRefreshTime'] ?? 'Inactive', status['nextRefreshTime'] == 'Active'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
          if (status['isRunning'] == true)
            TextButton(
              onPressed: () {
                weeklyRefreshService.stopService();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Weekly refresh service stopped')),
                );
              },
              child: const Text('Stop Service'),
            )
          else
            TextButton(
              onPressed: () {
                weeklyRefreshService.startService();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Weekly refresh service started')),
                );
              },
              child: const Text('Start Service'),
            ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, String value, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                value,
                style: TextStyle(
                  color: isActive ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
