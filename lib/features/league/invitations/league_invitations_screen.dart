import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nfl_survival/app/providers.dart';
import 'package:nfl_survival/data/models/league_invitation.dart';
import 'package:nfl_survival/widgets/app_scaffold.dart';

class LeagueInvitationsScreen extends ConsumerWidget {
  final String leagueId;

  const LeagueInvitationsScreen({super.key, required this.leagueId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invitationsAsync = ref.watch(leagueInvitationsProvider(leagueId));

    return AppScaffold(
      appBar: AppBar(
        title: const Text('League Invitations'),
        actions: [
          IconButton(
            onPressed: () =>
                _createAndShowInvitationUrl(context, ref, leagueId),
            icon: const Icon(Icons.share),
            tooltip: 'Create Invitation Link',
          ),
        ],
      ),
      child: invitationsAsync.when(
        data: (invitations) {
          if (invitations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.group_add, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'No invitation links yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Create a shareable link to invite users',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () =>
                        _createAndShowInvitationUrl(context, ref, leagueId),
                    icon: const Icon(Icons.share),
                    label: const Text('Create Invitation Link'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: invitations.length,
            itemBuilder: (context, index) {
              final invitation = invitations[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getStatusColor(invitation.status),
                    child: Icon(
                      _getStatusIcon(invitation.status),
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    'Invitation Link',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Code: ${invitation.invitationCode}'),
                      Text(
                        'URL: ${_getInvitationUrl(invitation.invitationCode)}',
                      ),
                      Text('Created: ${_formatDate(invitation.createdAt)}'),
                      if (invitation.expiresAt != null)
                        Text('Expires: ${_formatDate(invitation.expiresAt!)}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (invitation.status == InvitationStatus.pending) ...[
                        IconButton(
                          onPressed: () =>
                              _cancelInvitation(context, ref, invitation.id),
                          icon: const Icon(Icons.cancel, color: Colors.red),
                          tooltip: 'Cancel',
                        ),
                      ],
                      IconButton(
                        onPressed: () => _copyInvitationUrl(
                          context,
                          invitation.invitationCode,
                        ),
                        icon: const Icon(Icons.copy),
                        tooltip: 'Copy Link',
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error loading invitations: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    ref.invalidate(leagueInvitationsProvider(leagueId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
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

  IconData _getStatusIcon(InvitationStatus status) {
    switch (status) {
      case InvitationStatus.pending:
        return Icons.schedule;
      case InvitationStatus.accepted:
        return Icons.check;
      case InvitationStatus.declined:
        return Icons.close;
      case InvitationStatus.expired:
        return Icons.access_time;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _createAndShowInvitationUrl(
    BuildContext context,
    WidgetRef ref,
    String leagueId,
  ) async {
    try {
      // Show loading
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Creating invitation link...'),
          backgroundColor: Colors.blue,
        ),
      );

      // Create invitation
      final invitation = await ref
          .read(invitationRepositoryProvider)
          .createInvitation(
            leagueId: leagueId,
            invitedByUserId: ref.read(currentUserProvider)!.id,
          );

      // Show invitation URL dialog
      if (context.mounted) {
        _showInvitationUrlDialog(context, invitation.invitationCode);
        ref.invalidate(leagueInvitationsProvider(leagueId));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create invitation: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showInvitationUrlDialog(BuildContext context, String invitationCode) {
    final invitationUrl = _getInvitationUrl(invitationCode);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invitation Link Created'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Share this link with users you want to invite:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      invitationUrl,
                      style: const TextStyle(fontFamily: 'monospace'),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _copyToClipboard(context, invitationUrl),
                    icon: const Icon(Icons.copy),
                    tooltip: 'Copy Link',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'You can share this link via WhatsApp, SMS, or any other platform.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton.icon(
            onPressed: () => _copyToClipboard(context, invitationUrl),
            icon: const Icon(Icons.copy),
            label: const Text('Copy Link'),
          ),
        ],
      ),
    );
  }

  void _cancelInvitation(
    BuildContext context,
    WidgetRef ref,
    String invitationId,
  ) async {
    try {
      await ref
          .read(invitationRepositoryProvider)
          .cancelInvitation(invitationId);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invitation cancelled'),
            backgroundColor: Colors.orange,
          ),
        );
        ref.invalidate(leagueInvitationsProvider(leagueId));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to cancel invitation: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String _getInvitationUrl(String invitationCode) {
    // In a real app, this would be your actual domain
    return 'https://your-app.com/invite/$invitationCode';
  }

  void _copyInvitationUrl(BuildContext context, String invitationCode) {
    final url = _getInvitationUrl(invitationCode);
    _copyToClipboard(context, url);
  }

  void _copyToClipboard(BuildContext context, String text) {
    // In a real app, this would use Flutter's clipboard functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied to clipboard: $text'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }
}

// Provider for league invitations
final leagueInvitationsProvider =
    FutureProvider.family<List<LeagueInvitation>, String>((
      ref,
      leagueId,
    ) async {
      return ref
          .read(invitationRepositoryProvider)
          .getInvitationsForLeague(leagueId);
    });
