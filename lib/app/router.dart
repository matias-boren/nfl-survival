import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nfl_survival/app/providers.dart';
import 'package:nfl_survival/features/home/presentation/home_screen.dart';
import 'package:nfl_survival/features/league/detail/league_detail_screen.dart';
import 'package:nfl_survival/features/picks/make_pick/make_pick_screen.dart';
import 'package:nfl_survival/features/news/feed/news_feed_screen.dart';
import 'package:nfl_survival/features/settings/settings_screen.dart';
import 'package:nfl_survival/features/paywall/paywall_screen.dart';
import 'package:nfl_survival/features/paywall/premium_upgrade_screen.dart';
import 'package:nfl_survival/features/league/table/league_list_screen.dart';
import 'package:nfl_survival/features/picks/history/picks_history_screen.dart';
import 'package:nfl_survival/features/league/standings/league_standings_screen.dart';
import 'package:nfl_survival/features/auth/sign_in_screen.dart';
import 'package:nfl_survival/features/league/chat/league_chat_screen.dart';
import 'package:nfl_survival/features/league/create/league_create_screen.dart';
import 'package:nfl_survival/features/league/invitations/accept_invitation_screen.dart';
import 'package:nfl_survival/features/league/invitations/league_invitations_screen.dart';
import 'package:nfl_survival/features/admin/result_processing_screen.dart';
import 'package:nfl_survival/features/admin/automated_processing_screen.dart';
import 'package:nfl_survival/features/admin/live_scores_monitor_screen.dart';
import 'package:nfl_survival/features/league/join/join_leagues_screen.dart';
import 'package:nfl_survival/features/picks/league_selection/league_selection_screen.dart';
import 'package:nfl_survival/widgets/auth_guard.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/loading',
    redirect: (context, state) {
      final currentUser = ref.watch(currentUserProvider);
      final isSignInRoute = state.uri.path == '/signin' || state.uri.path == '/sign-in';
      final isLoadingRoute = state.uri.path == '/loading';
      
      // If user is authenticated and on signin page, redirect to home
      if (currentUser != null && isSignInRoute) {
        return '/';
      }
      
      // If user is not authenticated and not on signin page, redirect to signin
      if (currentUser == null && !isSignInRoute && !isLoadingRoute) {
        return '/signin';
      }
      
      // If user is authenticated and not on loading page, go to home
      if (currentUser != null && isLoadingRoute) {
        return '/';
      }
      
      // If user is not authenticated and on loading page, go to signin
      if (currentUser == null && isLoadingRoute) {
        return '/signin';
      }
      
      // No redirect needed
      return null;
    },
    routes: [
      GoRoute(
        path: '/loading',
        builder: (context, state) => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
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
        builder: (context, state) => const AuthGuard(child: LeagueCreateScreen()),
      ),
        GoRoute(
          path: '/join-leagues',
          builder: (context, state) => const AuthGuard(child: JoinLeaguesScreen()),
        ),
        GoRoute(
          path: '/admin/result-processing',
          builder: (context, state) => const AuthGuard(child: ResultProcessingScreen()),
        ),
        GoRoute(
          path: '/admin/automated-processing',
          builder: (context, state) => const AuthGuard(child: AutomatedProcessingScreen()),
        ),
        GoRoute(
          path: '/admin/live-scores',
          builder: (context, state) => const AuthGuard(child: LiveScoresMonitorScreen()),
        ),
      GoRoute(
        path: '/select-league', 
        builder: (context, state) => const AuthGuard(child: LeagueSelectionScreen()),
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
              child: LeagueStandingsScreen(leagueId: state.pathParameters['id']!),
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
              child: MakePickScreen(
                leagueId: state.pathParameters['id']!,
              ),
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
        builder: (context, state) => AuthGuard(
          child: AcceptInvitationScreen(
            invitationCode: state.pathParameters['code']!,
          ),
        ),
      ),
      GoRoute(path: '/paywall', builder: (context, state) => const PaywallScreen()),
      GoRoute(path: '/premium-upgrade', builder: (context, state) => const PremiumUpgradeScreen()),
    ],
  );
});
