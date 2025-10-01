import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick1/app/providers.dart';
import 'package:pick1/features/home/presentation/home_screen.dart';
import 'package:pick1/features/league/detail/league_detail_screen.dart';
import 'package:pick1/features/picks/make_pick/make_pick_screen.dart';
import 'package:pick1/features/news/feed/news_feed_screen.dart';
import 'package:pick1/features/settings/settings_screen.dart';
import 'package:pick1/features/paywall/paywall_screen.dart';
import 'package:pick1/features/paywall/premium_upgrade_screen.dart';
import 'package:pick1/features/league/table/league_list_screen.dart';
import 'package:pick1/features/picks/history/picks_history_screen.dart';
import 'package:pick1/features/league/standings/league_standings_screen.dart';
import 'package:pick1/features/auth/sign_in_screen.dart';
import 'package:pick1/features/league/chat/league_chat_screen.dart';
import 'package:pick1/features/league/create/league_create_screen.dart';
import 'package:pick1/features/league/invitations/accept_invitation_screen.dart';
import 'package:pick1/features/league/invitations/league_invitations_screen.dart';
import 'package:pick1/features/admin/result_processing_screen.dart';
import 'package:pick1/features/admin/automated_processing_screen.dart';
import 'package:pick1/features/admin/news_management_screen.dart';
import 'package:pick1/features/league/join/join_leagues_screen.dart';
import 'package:pick1/features/picks/league_selection/league_selection_screen.dart';
import 'package:pick1/widgets/auth_guard.dart';
import 'package:pick1/widgets/invitation_guard.dart';
import 'package:pick1/core/services/invitation_storage_service.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    redirect: (context, state) {
      final currentUser = ref.watch(currentUserProvider);
      final isSignInRoute =
          state.uri.path == '/signin' || state.uri.path == '/sign-in';
      final isLoadingRoute = state.uri.path == '/loading';
      final isInviteRoute = state.uri.path.startsWith('/invite/');
      final isAdminRoute = state.uri.path.startsWith('/admin/');
      
      print('🔄 Router redirect: path=${state.uri.path}, currentUser=${currentUser?.email}, isInviteRoute=$isInviteRoute');
      
      // CRITICAL: If we're on an invitation route, ALWAYS allow it to proceed
      // InvitationGuard will handle authentication
      if (isInviteRoute) {
        print('🔄 Router: Invitation route detected, allowing to proceed');
        return null;
      }

      // If user is authenticated and on signin page, check for redirect
      if (currentUser != null && isSignInRoute) {
        print('🔄 Router: Authenticated user on signin page');
        // Check for invitation code parameter first
        final inviteCode = state.uri.queryParameters['invite'];
        if (inviteCode != null && inviteCode.isNotEmpty) {
          print('🔄 Router: Found invite parameter: $inviteCode, redirecting to /invite/$inviteCode');
          return '/invite/$inviteCode';
        }
        // Then check for redirect parameter
        final redirectParam = state.uri.queryParameters['redirect'];
        if (redirectParam != null) {
          print('🔄 Router: Found redirect parameter: $redirectParam');
          return redirectParam;
        }
        print('🔄 Router: No redirect parameter, going to home');
        return '/';
      }

      // If user is not authenticated and not on special routes, redirect to signin
      // EXCEPT for invitation routes (handled by InvitationGuard) and admin routes (handled by AuthGuard)
      if (currentUser == null && !isSignInRoute && !isLoadingRoute && !isInviteRoute && !isAdminRoute) {
        print('🔄 Router: Redirecting unauthenticated user to signin');
        return '/signin';
      }


      // If user is authenticated and not on loading page, go to home
      if (currentUser != null && isLoadingRoute) {
        print('🔄 Router: User authenticated on loading page, checking for pending invitation...');
        // Check if there's a pending invitation code
        final pendingInvitationCode = InvitationStorageService.getPendingInvitationCode();
        if (pendingInvitationCode != null) {
          print('🔄 Router: Found pending invitation code: $pendingInvitationCode, redirecting to /invite/$pendingInvitationCode');
          InvitationStorageService.clearPendingInvitationCode();
          return '/invite/$pendingInvitationCode';
        }
        
        // Check if there's a stored redirect URL (from invitation flow)
        final redirectParam = state.uri.queryParameters['redirect'];
        if (redirectParam != null && redirectParam.isNotEmpty) {
          print('🔄 Router: Found redirect parameter: $redirectParam');
          return redirectParam;
        }
        print('🔄 Router: No pending invitation or redirect, going to home');
        return '/';
      }

      // If user is not authenticated and on loading page, go to signin
      if (currentUser == null && isLoadingRoute) {
        print('🔄 Router: Unauthenticated user on loading page, redirecting to signin');
        return '/signin';
      }

      // No redirect needed
      print('🔄 Router: No redirect needed, allowing to proceed');
      return null;
    },
    routes: [
      GoRoute(
        path: '/loading',
        builder: (context, state) =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const AuthGuard(child: HomeScreen()),
      ),
      GoRoute(
        path: '/signin',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/leagues',
        builder: (context, state) => const AuthGuard(child: LeagueListScreen()),
      ),
      GoRoute(
        path: '/create-league',
        builder: (context, state) =>
            const AuthGuard(child: LeagueCreateScreen()),
      ),
      GoRoute(
        path: '/join-leagues',
        builder: (context, state) =>
            const AuthGuard(child: JoinLeaguesScreen()),
      ),
      GoRoute(
        path: '/admin/result-processing',
        builder: (context, state) =>
            const AuthGuard(child: ResultProcessingScreen()),
      ),
      GoRoute(
        path: '/admin/automated-processing',
        builder: (context, state) =>
            const AuthGuard(child: AutomatedProcessingScreen()),
      ),
      GoRoute(
        path: '/admin/news-management',
        builder: (context, state) =>
            const AuthGuard(child: NewsManagementScreen()),
      ),
      GoRoute(
        path: '/select-league',
        builder: (context, state) =>
            const AuthGuard(child: LeagueSelectionScreen()),
      ),
      GoRoute(
        path: '/league/:id',
        builder: (context, state) => AuthGuard(
          child: LeagueDetailScreen(leagueId: state.pathParameters['id']!),
        ),
        routes: [
          GoRoute(
            path: 'standings',
            builder: (context, state) => AuthGuard(
              child: LeagueStandingsScreen(
                leagueId: state.pathParameters['id']!,
              ),
            ),
          ),
          GoRoute(
            path: 'chat',
            builder: (context, state) => AuthGuard(
              child: LeagueChatScreen(leagueId: state.pathParameters['id']!),
            ),
          ),
          GoRoute(
            path: 'pick',
            builder: (context, state) => AuthGuard(
              child: MakePickScreen(leagueId: state.pathParameters['id']!),
            ),
          ),
          GoRoute(
            path: 'invitations',
            builder: (context, state) => AuthGuard(
              child: LeagueInvitationsScreen(
                leagueId: state.pathParameters['id']!,
              ),
            ),
          ),
          GoRoute(
            path: 'picks-history',
            builder: (context, state) => AuthGuard(
              child: PicksHistoryScreen(
                leagueId: state.pathParameters['id']!,
                week: 1, // Default to week 1, could be made dynamic later
              ),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/news',
        builder: (context, state) => const AuthGuard(child: NewsFeedScreen()),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const AuthGuard(child: SettingsScreen()),
      ),
      GoRoute(
        path: '/invite/:code',
        builder: (context, state) => InvitationGuard(
          invitationCode: state.pathParameters['code']!,
          child: AcceptInvitationScreen(
            invitationCode: state.pathParameters['code']!,
          ),
        ),
      ),
      GoRoute(
        path: '/paywall',
        builder: (context, state) => const AuthGuard(child: PaywallScreen()),
      ),
      GoRoute(
        path: '/premium-upgrade',
        builder: (context, state) =>
            const AuthGuard(child: PremiumUpgradeScreen()),
      ),
    ],
  );
});
