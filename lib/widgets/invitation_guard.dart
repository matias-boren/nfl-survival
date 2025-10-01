import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pick1/app/providers.dart';
import 'package:pick1/core/services/invitation_storage_service.dart';

class InvitationGuard extends ConsumerWidget {
  final Widget child;
  final String invitationCode;

  const InvitationGuard({
    super.key, 
    required this.child,
    required this.invitationCode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    print('🔗 InvitationGuard: Building with invitationCode: $invitationCode, currentUser: ${currentUser?.email}');
    print('🔗 InvitationGuard: Current URL: ${GoRouterState.of(context).uri}');

    if (currentUser == null) {
      print('🔗 InvitationGuard: User not authenticated, showing invitation preview');
      // User is not authenticated, show invitation preview and login prompt
      return _buildInvitationPreview(context, ref);
    }

    print('🔗 InvitationGuard: User authenticated, showing invitation acceptance screen');
    // User is authenticated, show the invitation acceptance screen
    return child;
  }

  Widget _buildInvitationPreview(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('League Invitation'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.group_add,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 24),
              const Text(
                'You\'ve been invited to join a league!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Sign in to your account to accept this invitation and join the league.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final currentUser = ref.read(currentUserProvider);
                    print('🔗 InvitationGuard: Accept button clicked, currentUser: ${currentUser?.email}');
                    
                    if (currentUser == null) {
                      // User not authenticated, redirect to sign in
                      print('🔗 InvitationGuard: User not authenticated, redirecting to signin');
                      context.go('/signin?invite=$invitationCode');
                    } else {
                      // User is authenticated, redirect to invitation acceptance screen
                      print('🔗 InvitationGuard: User authenticated, redirecting to invitation acceptance');
                      context.go('/invite/$invitationCode');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    ref.watch(currentUserProvider) == null 
                        ? 'Sign In to Accept Invitation'
                        : 'Accept Invitation',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.go('/'),
                child: const Text('Go to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
