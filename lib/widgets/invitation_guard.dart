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

    if (currentUser == null) {
      // Store the invitation code for later use after authentication
      InvitationStorageService.storeInvitationCode(invitationCode);
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
                    // Redirect to sign in with invitation code as query parameter
                    print('🔗 InvitationGuard: Redirecting to signin with invitation code');
                    context.go('/signin?invite=$invitationCode');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Sign In to Accept Invitation',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
