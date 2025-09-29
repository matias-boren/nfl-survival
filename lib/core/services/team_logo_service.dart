import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TeamLogoService {
  static const Map<String, String> _teamLogos = {
    'ARI': 'https://a.espncdn.com/i/teamlogos/nfl/500/ari.png',
    'ATL': 'https://a.espncdn.com/i/teamlogos/nfl/500/atl.png',
    'BAL': 'https://a.espncdn.com/i/teamlogos/nfl/500/bal.png',
    'BUF': 'https://a.espncdn.com/i/teamlogos/nfl/500/buf.png',
    'CAR': 'https://a.espncdn.com/i/teamlogos/nfl/500/car.png',
    'CHI': 'https://a.espncdn.com/i/teamlogos/nfl/500/chi.png',
    'CIN': 'https://a.espncdn.com/i/teamlogos/nfl/500/cin.png',
    'CLE': 'https://a.espncdn.com/i/teamlogos/nfl/500/cle.png',
    'DAL': 'https://a.espncdn.com/i/teamlogos/nfl/500/dal.png',
    'DEN': 'https://a.espncdn.com/i/teamlogos/nfl/500/den.png',
    'DET': 'https://a.espncdn.com/i/teamlogos/nfl/500/det.png',
    'GB': 'https://a.espncdn.com/i/teamlogos/nfl/500/gb.png',
    'HOU': 'https://a.espncdn.com/i/teamlogos/nfl/500/hou.png',
    'IND': 'https://a.espncdn.com/i/teamlogos/nfl/500/ind.png',
    'JAX': 'https://a.espncdn.com/i/teamlogos/nfl/500/jax.png',
    'KC': 'https://a.espncdn.com/i/teamlogos/nfl/500/kc.png',
    'LV': 'https://a.espncdn.com/i/teamlogos/nfl/500/lv.png',
    'LAC': 'https://a.espncdn.com/i/teamlogos/nfl/500/lac.png',
    'LAR': 'https://a.espncdn.com/i/teamlogos/nfl/500/lar.png',
    'MIA': 'https://a.espncdn.com/i/teamlogos/nfl/500/mia.png',
    'MIN': 'https://a.espncdn.com/i/teamlogos/nfl/500/min.png',
    'NE': 'https://a.espncdn.com/i/teamlogos/nfl/500/ne.png',
    'NO': 'https://a.espncdn.com/i/teamlogos/nfl/500/no.png',
    'NYG': 'https://a.espncdn.com/i/teamlogos/nfl/500/nyg.png',
    'NYJ': 'https://a.espncdn.com/i/teamlogos/nfl/500/nyj.png',
    'PHI': 'https://a.espncdn.com/i/teamlogos/nfl/500/phi.png',
    'PIT': 'https://a.espncdn.com/i/teamlogos/nfl/500/pit.png',
    'SF': 'https://a.espncdn.com/i/teamlogos/nfl/500/sf.png',
    'SEA': 'https://a.espncdn.com/i/teamlogos/nfl/500/sea.png',
    'TB': 'https://a.espncdn.com/i/teamlogos/nfl/500/tb.png',
    'TEN': 'https://a.espncdn.com/i/teamlogos/nfl/500/ten.png',
    'WSH': 'https://a.espncdn.com/i/teamlogos/nfl/500/wsh.png',
  };

  static const Map<String, Color> _teamColors = {
    'ARI': Color(0xFF97233F),
    'ATL': Color(0xFFA71930),
    'BAL': Color(0xFF241773),
    'BUF': Color(0xFF00338D),
    'CAR': Color(0xFF0085CA),
    'CHI': Color(0xFF0B162A),
    'CIN': Color(0xFFFB4F14),
    'CLE': Color(0xFF311D00),
    'DAL': Color(0xFF003594),
    'DEN': Color(0xFFFB4F14),
    'DET': Color(0xFF0076B6),
    'GB': Color(0xFF203731),
    'HOU': Color(0xFF03202F),
    'IND': Color(0xFF002C5F),
    'JAX': Color(0xFF006778),
    'KC': Color(0xFFE31837),
    'LV': Color(0xFF000000),
    'LAC': Color(0xFF0080C6),
    'LAR': Color(0xFF003594),
    'MIA': Color(0xFF008E97),
    'MIN': Color(0xFF4F2683),
    'NE': Color(0xFF002244),
    'NO': Color(0xFFD3BC8D),
    'NYG': Color(0xFF0B2265),
    'NYJ': Color(0xFF125740),
    'PHI': Color(0xFF004C54),
    'PIT': Color(0xFFFFB612),
    'SF': Color(0xFFAA0000),
    'SEA': Color(0xFF002244),
    'TB': Color(0xFFD50A0A),
    'TEN': Color(0xFF0C2340),
    'WSH': Color(0xFF5A1414),
  };

  static String? getTeamLogoUrl(String teamAbbreviation) {
    return _teamLogos[teamAbbreviation.toUpperCase()];
  }

  static Color getTeamColor(String teamAbbreviation) {
    return _teamColors[teamAbbreviation.toUpperCase()] ?? Colors.grey;
  }

  static Widget buildTeamLogo({
    required String teamAbbreviation,
    double size = 40.0,
    bool showFallback = true,
  }) {
    final logoUrl = getTeamLogoUrl(teamAbbreviation);

    if (logoUrl == null && !showFallback) {
      return SizedBox(width: size, height: size);
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: getTeamColor(teamAbbreviation).withOpacity(0.1),
        border: Border.all(
          color: getTeamColor(teamAbbreviation).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: logoUrl != null
          ? ClipOval(
              child: CachedNetworkImage(
                imageUrl: logoUrl,
                width: size,
                height: size,
                fit: BoxFit.cover,
                memCacheWidth: (size * 2).round(), // Cache at 2x resolution
                memCacheHeight: (size * 2).round(),
                errorWidget: (context, url, error) {
                  return _buildFallbackLogo(teamAbbreviation, size);
                },
                placeholder: (context, url) {
                  return Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                },
              ),
            )
          : _buildFallbackLogo(teamAbbreviation, size),
    );
  }

  static Widget _buildFallbackLogo(String teamAbbreviation, double size) {
    return Center(
      child: Text(
        teamAbbreviation,
        style: TextStyle(
          color: getTeamColor(teamAbbreviation),
          fontWeight: FontWeight.bold,
          fontSize: size * 0.4,
        ),
      ),
    );
  }
}
