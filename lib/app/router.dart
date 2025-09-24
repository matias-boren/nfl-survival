import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nfl_survival/features/home/presentation/home_screen.dart';
import 'package:nfl_survival/features/league/detail/league_detail_screen.dart';
import 'package:nfl_survival/features/league/table/league_list_screen.dart';
import 'package:nfl_survival/features/league/standings/league_standings_screen.dart';
import 'package:nfl_survival/features/picks/make_pick/make_pick_screen.dart';
import 'package:nfl_survival/features/picks/history/picks_history_screen.dart';
import 'package:nfl_survival/features/friends/list/friends_list_screen.dart';
import 'package:nfl_survival/features/news/feed/news_feed_screen.dart';
import 'package:nfl_survival/features/settings/settings_screen.dart';
import 'package:nfl_survival/features/paywall/paywall_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/leagues', builder: (context, state) => const LeagueListScreen()),
      GoRoute(
        path: '/league/:id',
        builder: (context, state) => LeagueDetailScreen(leagueId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/league/:id/standings',
        builder: (context, state) => LeagueStandingsScreen(leagueId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/picks/:leagueId/:week',
        builder: (context, state) => MakePickScreen(
          leagueId: state.pathParameters['leagueId']!,
          week: int.parse(state.pathParameters['week']!),
        ),
      ),
      GoRoute(
        path: '/picks/:leagueId/:week/history',
        builder: (context, state) => PicksHistoryScreen(
          leagueId: state.pathParameters['leagueId']!,
          week: int.parse(state.pathParameters['week']!),
        ),
      ),
      GoRoute(path: '/friends', builder: (context, state) => const FriendsListScreen()),
      GoRoute(path: '/news', builder: (context, state) => const NewsFeedScreen()),
      GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
      GoRoute(path: '/paywall', builder: (context, state) => const PaywallScreen()),
    ],
  );
});
