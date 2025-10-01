import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pick1/app/providers.dart';
import 'package:pick1/data/models/league_invitation.dart';
import 'package:pick1/data/models/league.dart';
import 'package:pick1/widgets/app_scaffold.dart';

class AcceptInvitationScreen extends ConsumerStatefulWidget {
  final String invitationCode;

  const AcceptInvitationScreen({super.key, required this.invitationCode});

  @override
  ConsumerState<AcceptInvitationScreen> createState() =>
      _AcceptInvitationScreenState();
}

class _AcceptInvitationScreenState
    extends ConsumerState<AcceptInvitationScreen> {
  bool _isLoading = false;
  LeagueInvitation? _invitation;
  League? _league;
  String? _inviterDisplayName;
  int _acceptanceCount = 0;
  bool _hasUserAccepted = false;

  @override
  void initState() {
    super.initState();
    _loadInvitation();
  }

  Future<void> _loadInvitation() async {
    print('🔗 AcceptInvitationScreen: Loading invitation with code: ${widget.invitationCode}');
    setState(() => _isLoading = true);

    try {
      final invitation = await ref
          .read(invitationRepositoryProvider)
          .getInvitationByCode(widget.invitationCode);
      print('🔗 AcceptInvitationScreen: Found invitation: ${invitation?.id}');
      
      if (invitation != null) {
        final league = await ref
            .read(leagueRepositoryProvider)
            .getLeague(invitation.leagueId);
        print('🔗 AcceptInvitationScreen: Found league: ${league?.name}');

        // Get inviter's display name (in a real app, this would fetch from user service)
        // For now, we'll use a mock approach
        final inviterDisplayName = await _getInviterDisplayName(
          invitation.invitedByUserId,
        );
        print('🔗 AcceptInvitationScreen: Inviter display name: $inviterDisplayName');

        // Get acceptance count and check if current user has already accepted
        final currentUser = ref.read(currentUserProvider);
        int acceptanceCount = 0;
        bool hasUserAccepted = false;
        
        if (currentUser != null) {
          acceptanceCount = await ref
              .read(invitationRepositoryProvider)
              .getInvitationAcceptanceCount(invitation.invitationCode);
          hasUserAccepted = await ref
              .read(invitationRepositoryProvider)
              .hasUserAcceptedInvitation(invitation.invitationCode, currentUser.id);
        }

        setState(() {
          _invitation = invitation;
          _league = league;
          _inviterDisplayName = inviterDisplayName;
          _acceptanceCount = acceptanceCount;
          _hasUserAccepted = hasUserAccepted;
        });
      } else {
        print('🔗 AcceptInvitationScreen: No invitation found for code: ${widget.invitationCode}');
      }
    } catch (e) {
      print('🔗 AcceptInvitationScreen: Error loading invitation: $e');
      // Handle error
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<String> _getInviterDisplayName(String userId) async {
    try {
      final user = await ref.read(userRepositoryProvider).getUserById(userId);
      return user?.displayName ?? 'Unknown User';
    } catch (e) {
      return 'Unknown User';
    }
  }

  @override
  Widget build(BuildContext context) {
    print('🔗 AcceptInvitationScreen: Building with invitationCode: ${widget.invitationCode}');
    print('🔗 AcceptInvitationScreen: _isLoading: $_isLoading, _invitation: ${_invitation?.id}, _league: ${_league?.name}');
    
    if (_isLoading) {
      return AppScaffold(
        appBar: AppBar(title: const Text('Invitation')),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_invitation == null || _league == null) {
      return AppScaffold(
        appBar: AppBar(title: const Text('Invalid Invitation')),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                'Invalid Invitation',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'This invitation code is not valid or has expired.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      );
    }

    return AppScaffold(
      appBar: AppBar(title: const Text('League Invitation')),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // League Info Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.group, size: 32, color: Colors.blue),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _league!.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Invited by: ${_inviterDisplayName ?? 'Unknown User'}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${_acceptanceCount} people have joined',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildLeagueDetails(),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Invitation Details
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Invitation Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow('Code', _invitation!.invitationCode),
                    _buildDetailRow(
                      'Created',
                      _formatDate(_invitation!.createdAt),
                    ),
                    if (_invitation!.expiresAt != null)
                      _buildDetailRow(
                        'Expires',
                        _formatDate(_invitation!.expiresAt!),
                      ),
                    _buildDetailRow(
                      'Status',
                      _getStatusText(_invitation!.status),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Action Buttons
            if (_invitation!.status == InvitationStatus.pending) ...[
              if (_hasUserAccepted) ...[
                // User has already accepted
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        'You have already joined this league!',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => context.go('/league/${_league!.id}'),
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Go to League'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ] else ...[
                // User hasn't accepted yet
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _acceptInvitation,
                    icon: const Icon(Icons.check),
                    label: const Text('Accept Invitation'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _declineInvitation,
                    icon: const Icon(Icons.close),
                    label: const Text('Decline Invitation'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ] else ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _getStatusColor(_invitation!.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _getStatusColor(_invitation!.status),
                  ),
                ),
                child: Text(
                  _getStatusMessage(_invitation!.status),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _getStatusColor(_invitation!.status),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLeagueDetails() {
    return Column(
      children: [
        _buildDetailRow('Max Losses', _league!.settings.maxLosses.toString()),
        _buildDetailRow(
          'Tiebreaker',
          'Points For (total points scored by picked teams)',
        ),
        _buildDetailRow(
          'Visibility',
          _league!.visibility == LeagueVisibility.PUBLIC ? 'Public' : 'Private',
        ),
        _buildDetailRow(
          'Allow Team Reuse',
          _league!.settings.allowTeamReuse ? 'Yes' : 'No',
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _getStatusText(InvitationStatus status) {
    switch (status) {
      case InvitationStatus.pending:
        return 'Pending';
      case InvitationStatus.accepted:
        return 'Accepted';
      case InvitationStatus.declined:
        return 'Declined';
      case InvitationStatus.expired:
        return 'Expired';
    }
  }

  Color _getStatusColor(InvitationStatus status) {
    switch (status) {
      case InvitationStatus.pending:
        return Colors.orange;
      case InvitationStatus.accepted:
        return Colors.green;
      case InvitationStatus.declined:
        return Colors.red;
      case InvitationStatus.expired:
        return Colors.grey;
    }
  }

  String _getStatusMessage(InvitationStatus status) {
    switch (status) {
      case InvitationStatus.pending:
        return 'You can accept or decline this invitation';
      case InvitationStatus.accepted:
        return 'You have already accepted this invitation';
      case InvitationStatus.declined:
        return 'You have declined this invitation';
      case InvitationStatus.expired:
        return 'This invitation has expired';
    }
  }

  Future<void> _acceptInvitation() async {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return;

    setState(() => _isLoading = true);

    try {
      await ref
          .read(invitationRepositoryProvider)
          .acceptInvitation(_invitation!.invitationCode, currentUser.id);

      // Add user to league
      final updatedUser = currentUser.copyWith(
        joinedLeagueIds: [...currentUser.joinedLeagueIds, _league!.id],
      );
      ref.read(currentUserProvider.notifier).state = updatedUser;

      // Refresh acceptance count and user status
      final newAcceptanceCount = await ref
          .read(invitationRepositoryProvider)
          .getInvitationAcceptanceCount(_invitation!.invitationCode);
      
      setState(() {
        _acceptanceCount = newAcceptanceCount;
        _hasUserAccepted = true;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully joined the league!'),
            backgroundColor: Colors.green,
          ),
        );
        // Don't navigate away - let user see the updated UI
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to accept invitation: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _declineInvitation() async {
    setState(() => _isLoading = true);

    try {
      await ref
          .read(invitationRepositoryProvider)
          .declineInvitation(_invitation!.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invitation declined'),
            backgroundColor: Colors.orange,
          ),
        );
        context.go('/');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to decline invitation: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
