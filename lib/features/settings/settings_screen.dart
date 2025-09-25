import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nfl_survival/app/providers.dart';
import 'package:nfl_survival/data/billing/mock_billing_repository.dart';
import 'package:nfl_survival/widgets/app_scaffold.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepo = ref.read(authRepositoryProvider);
    final billingRepo = ref.read(billingRepositoryProvider);
    final isPremium = ref.watch(premiumStatusProvider).valueOrNull ?? false;
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
          
          // Testing controls (only in debug mode)
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Testing Controls',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          ListTile(
            title: Text(isPremium ? 'Disable Premium (Testing)' : 'Enable Premium (Testing)'),
            subtitle: const Text('Toggle premium status for testing'),
            leading: Icon(isPremium ? Icons.star : Icons.star_border),
            onTap: () {
              final mockBilling = billingRepo as MockBillingRepository;
              mockBilling.togglePremiumStatus();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isPremium ? 'Premium disabled' : 'Premium enabled'),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Automated Processing'),
            subtitle: const Text('Monitor automated result processing'),
            leading: const Icon(Icons.sync),
            onTap: () => context.go('/admin/automated-processing'),
          ),
          ListTile(
            title: const Text('Live Scores Monitor'),
            subtitle: const Text('Monitor real-time score updates'),
            leading: const Icon(Icons.sports_score),
            onTap: () => context.go('/admin/live-scores'),
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
}
