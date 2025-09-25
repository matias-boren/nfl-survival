// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EspnGame _$EspnGameFromJson(Map<String, dynamic> json) => _EspnGame(
  id: json['id'] as String,
  name: json['name'] as String,
  shortName: json['shortName'] as String,
  date: EspnDate.fromJson(json['date'] as Map<String, dynamic>),
  competitions: (json['competitions'] as List<dynamic>)
      .map((e) => EspnCompetition.fromJson(e as Map<String, dynamic>))
      .toList(),
  status: EspnStatus.fromJson(json['status'] as Map<String, dynamic>),
  week: EspnWeek.fromJson(json['week'] as Map<String, dynamic>),
  season: EspnSeason.fromJson(json['season'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EspnGameToJson(_EspnGame instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'shortName': instance.shortName,
  'date': instance.date,
  'competitions': instance.competitions,
  'status': instance.status,
  'week': instance.week,
  'season': instance.season,
};

_EspnDate _$EspnDateFromJson(Map<String, dynamic> json) =>
    _EspnDate(date: json['date'] as String);

Map<String, dynamic> _$EspnDateToJson(_EspnDate instance) => <String, dynamic>{
  'date': instance.date,
};

_EspnCompetition _$EspnCompetitionFromJson(Map<String, dynamic> json) =>
    _EspnCompetition(
      id: json['id'] as String,
      uid: json['uid'] as String,
      date: json['date'] as String,
      attendance: json['attendance'] as String,
      type: EspnType.fromJson(json['type'] as Map<String, dynamic>),
      timeValid: json['timeValid'] as bool,
      competitors: (json['competitors'] as List<dynamic>)
          .map((e) => EspnCompetitor.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: EspnStatus.fromJson(json['status'] as Map<String, dynamic>),
      broadcast: json['broadcast'] == null
          ? null
          : EspnBroadcast.fromJson(json['broadcast'] as Map<String, dynamic>),
      venue: EspnVenue.fromJson(json['venue'] as Map<String, dynamic>),
      startDate: (json['startDate'] as List<dynamic>)
          .map((e) => EspnStartDate.fromJson(e as Map<String, dynamic>))
          .toList(),
      weather: (json['weather'] as List<dynamic>)
          .map((e) => EspnWeather.fromJson(e as Map<String, dynamic>))
          .toList(),
      referee: json['referee'] == null
          ? null
          : EspnReferee.fromJson(json['referee'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EspnCompetitionToJson(_EspnCompetition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'date': instance.date,
      'attendance': instance.attendance,
      'type': instance.type,
      'timeValid': instance.timeValid,
      'competitors': instance.competitors,
      'status': instance.status,
      'broadcast': instance.broadcast,
      'venue': instance.venue,
      'startDate': instance.startDate,
      'weather': instance.weather,
      'referee': instance.referee,
    };

_EspnCompetitor _$EspnCompetitorFromJson(Map<String, dynamic> json) =>
    _EspnCompetitor(
      id: json['id'] as String,
      uid: json['uid'] as String,
      type: json['type'] as String,
      order: json['order'] as String,
      homeAway: json['homeAway'] as String,
      team: EspnTeam.fromJson(json['team'] as Map<String, dynamic>),
      score: json['score'] == null
          ? null
          : EspnScore.fromJson(json['score'] as Map<String, dynamic>),
      records: (json['records'] as List<dynamic>)
          .map((e) => EspnRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      winners: (json['winners'] as List<dynamic>?)
          ?.map((e) => EspnWinner.fromJson(e as Map<String, dynamic>))
          .toList(),
      statistics: (json['statistics'] as List<dynamic>?)
          ?.map((e) => EspnStatistic.fromJson(e as Map<String, dynamic>))
          .toList(),
      leaders: (json['leaders'] as List<dynamic>?)
          ?.map((e) => EspnLeader.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EspnCompetitorToJson(_EspnCompetitor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'type': instance.type,
      'order': instance.order,
      'homeAway': instance.homeAway,
      'team': instance.team,
      'score': instance.score,
      'records': instance.records,
      'winners': instance.winners,
      'statistics': instance.statistics,
      'leaders': instance.leaders,
    };

_EspnTeam _$EspnTeamFromJson(Map<String, dynamic> json) => _EspnTeam(
  id: json['id'] as String,
  uid: json['uid'] as String,
  location: json['location'] as String,
  name: json['name'] as String,
  abbreviation: json['abbreviation'] as String,
  displayName: json['displayName'] as String,
  shortDisplayName: json['shortDisplayName'] as String,
  color: json['color'] as String,
  alternateColor: json['alternateColor'] as String,
  isActive: json['isActive'] as bool,
  logo: EspnLogo.fromJson(json['logo'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EspnTeamToJson(_EspnTeam instance) => <String, dynamic>{
  'id': instance.id,
  'uid': instance.uid,
  'location': instance.location,
  'name': instance.name,
  'abbreviation': instance.abbreviation,
  'displayName': instance.displayName,
  'shortDisplayName': instance.shortDisplayName,
  'color': instance.color,
  'alternateColor': instance.alternateColor,
  'isActive': instance.isActive,
  'logo': instance.logo,
};

_EspnLogo _$EspnLogoFromJson(Map<String, dynamic> json) => _EspnLogo(
  href: json['href'] as String,
  width: (json['width'] as num).toInt(),
  height: (json['height'] as num).toInt(),
  alt: json['alt'] as String,
  rel: (json['rel'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$EspnLogoToJson(_EspnLogo instance) => <String, dynamic>{
  'href': instance.href,
  'width': instance.width,
  'height': instance.height,
  'alt': instance.alt,
  'rel': instance.rel,
};

_EspnScore _$EspnScoreFromJson(Map<String, dynamic> json) => _EspnScore(
  value: json['value'] as String,
  displayValue: json['displayValue'] as String,
);

Map<String, dynamic> _$EspnScoreToJson(_EspnScore instance) =>
    <String, dynamic>{
      'value': instance.value,
      'displayValue': instance.displayValue,
    };

_EspnRecord _$EspnRecordFromJson(Map<String, dynamic> json) => _EspnRecord(
  name: json['name'] as String,
  abbreviation: json['abbreviation'] as String,
  type: json['type'] as String,
  summary: json['summary'] as String,
);

Map<String, dynamic> _$EspnRecordToJson(_EspnRecord instance) =>
    <String, dynamic>{
      'name': instance.name,
      'abbreviation': instance.abbreviation,
      'type': instance.type,
      'summary': instance.summary,
    };

_EspnWinner _$EspnWinnerFromJson(Map<String, dynamic> json) => _EspnWinner(
  value: json['value'] as String,
  displayValue: json['displayValue'] as String,
);

Map<String, dynamic> _$EspnWinnerToJson(_EspnWinner instance) =>
    <String, dynamic>{
      'value': instance.value,
      'displayValue': instance.displayValue,
    };

_EspnStatistic _$EspnStatisticFromJson(Map<String, dynamic> json) =>
    _EspnStatistic(
      label: json['label'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$EspnStatisticToJson(_EspnStatistic instance) =>
    <String, dynamic>{'label': instance.label, 'value': instance.value};

_EspnLeader _$EspnLeaderFromJson(Map<String, dynamic> json) => _EspnLeader(
  displayName: json['displayName'] as String,
  shortDisplayName: json['shortDisplayName'] as String,
  abbreviation: json['abbreviation'] as String,
  leaders: EspnLeaderLeaders.fromJson(json['leaders'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EspnLeaderToJson(_EspnLeader instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'shortDisplayName': instance.shortDisplayName,
      'abbreviation': instance.abbreviation,
      'leaders': instance.leaders,
    };

_EspnLeaderLeaders _$EspnLeaderLeadersFromJson(Map<String, dynamic> json) =>
    _EspnLeaderLeaders(
      value: json['value'] as String,
      displayValue: json['displayValue'] as String,
    );

Map<String, dynamic> _$EspnLeaderLeadersToJson(_EspnLeaderLeaders instance) =>
    <String, dynamic>{
      'value': instance.value,
      'displayValue': instance.displayValue,
    };

_EspnStatus _$EspnStatusFromJson(Map<String, dynamic> json) => _EspnStatus(
  clock: (json['clock'] as num).toInt(),
  displayClock: json['displayClock'] as String,
  period: (json['period'] as num).toInt(),
  type: EspnType.fromJson(json['type'] as Map<String, dynamic>),
  completed: json['completed'] as bool,
  description: json['description'] as String,
  detail: json['detail'] as String,
  shortDetail: json['shortDetail'] as String,
);

Map<String, dynamic> _$EspnStatusToJson(_EspnStatus instance) =>
    <String, dynamic>{
      'clock': instance.clock,
      'displayClock': instance.displayClock,
      'period': instance.period,
      'type': instance.type,
      'completed': instance.completed,
      'description': instance.description,
      'detail': instance.detail,
      'shortDetail': instance.shortDetail,
    };

_EspnType _$EspnTypeFromJson(Map<String, dynamic> json) => _EspnType(
  id: json['id'] as String,
  abbreviation: json['abbreviation'] as String,
);

Map<String, dynamic> _$EspnTypeToJson(_EspnType instance) => <String, dynamic>{
  'id': instance.id,
  'abbreviation': instance.abbreviation,
};

_EspnBroadcast _$EspnBroadcastFromJson(Map<String, dynamic> json) =>
    _EspnBroadcast(
      market: json['market'] as String,
      names: (json['names'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$EspnBroadcastToJson(_EspnBroadcast instance) =>
    <String, dynamic>{'market': instance.market, 'names': instance.names};

_EspnVenue _$EspnVenueFromJson(Map<String, dynamic> json) => _EspnVenue(
  id: json['id'] as String,
  fullName: json['fullName'] as String,
  address: json['address'] as String,
  city: EspnCity.fromJson(json['city'] as Map<String, dynamic>),
  state: EspnState.fromJson(json['state'] as Map<String, dynamic>),
  zip: json['zip'] as String,
  country: json['country'] as String,
  capacity: (json['capacity'] as num).toInt(),
  grass: json['grass'] as bool,
  indoor: json['indoor'] as bool,
);

Map<String, dynamic> _$EspnVenueToJson(_EspnVenue instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'zip': instance.zip,
      'country': instance.country,
      'capacity': instance.capacity,
      'grass': instance.grass,
      'indoor': instance.indoor,
    };

_EspnCity _$EspnCityFromJson(Map<String, dynamic> json) =>
    _EspnCity(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$EspnCityToJson(_EspnCity instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

_EspnState _$EspnStateFromJson(Map<String, dynamic> json) => _EspnState(
  id: json['id'] as String,
  name: json['name'] as String,
  abbreviation: json['abbreviation'] as String,
);

Map<String, dynamic> _$EspnStateToJson(_EspnState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'abbreviation': instance.abbreviation,
    };

_EspnStartDate _$EspnStartDateFromJson(Map<String, dynamic> json) =>
    _EspnStartDate(
      value: json['value'] as String,
      displayValue: json['displayValue'] as String,
    );

Map<String, dynamic> _$EspnStartDateToJson(_EspnStartDate instance) =>
    <String, dynamic>{
      'value': instance.value,
      'displayValue': instance.displayValue,
    };

_EspnWeather _$EspnWeatherFromJson(Map<String, dynamic> json) => _EspnWeather(
  displayValue: (json['displayValue'] as num).toInt(),
  highTemperature: (json['highTemperature'] as num).toInt(),
  conditionId: json['conditionId'] as String,
  link: json['link'] as String,
);

Map<String, dynamic> _$EspnWeatherToJson(_EspnWeather instance) =>
    <String, dynamic>{
      'displayValue': instance.displayValue,
      'highTemperature': instance.highTemperature,
      'conditionId': instance.conditionId,
      'link': instance.link,
    };

_EspnReferee _$EspnRefereeFromJson(Map<String, dynamic> json) => _EspnReferee(
  id: json['id'] as String,
  fullName: json['fullName'] as String,
  displayName: json['displayName'] as String,
  shortName: json['shortName'] as String,
  homeAway: json['homeAway'] as String,
);

Map<String, dynamic> _$EspnRefereeToJson(_EspnReferee instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'displayName': instance.displayName,
      'shortName': instance.shortName,
      'homeAway': instance.homeAway,
    };

_EspnWeek _$EspnWeekFromJson(Map<String, dynamic> json) =>
    _EspnWeek(number: (json['number'] as num).toInt());

Map<String, dynamic> _$EspnWeekToJson(_EspnWeek instance) => <String, dynamic>{
  'number': instance.number,
};

_EspnSeason _$EspnSeasonFromJson(Map<String, dynamic> json) => _EspnSeason(
  year: (json['year'] as num).toInt(),
  type: (json['type'] as num).toInt(),
);

Map<String, dynamic> _$EspnSeasonToJson(_EspnSeason instance) =>
    <String, dynamic>{'year': instance.year, 'type': instance.type};

_EspnNflResponse _$EspnNflResponseFromJson(Map<String, dynamic> json) =>
    _EspnNflResponse(
      league: json['league'] as String,
      season: EspnSeason.fromJson(json['season'] as Map<String, dynamic>),
      week: EspnWeek.fromJson(json['week'] as Map<String, dynamic>),
      events: (json['events'] as List<dynamic>)
          .map((e) => EspnGame.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EspnNflResponseToJson(_EspnNflResponse instance) =>
    <String, dynamic>{
      'league': instance.league,
      'season': instance.season,
      'week': instance.week,
      'events': instance.events,
    };

_EspnTeamsResponse _$EspnTeamsResponseFromJson(Map<String, dynamic> json) =>
    _EspnTeamsResponse(
      league: json['league'] as String,
      season: EspnSeason.fromJson(json['season'] as Map<String, dynamic>),
      teams: (json['teams'] as List<dynamic>)
          .map((e) => EspnTeam.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EspnTeamsResponseToJson(_EspnTeamsResponse instance) =>
    <String, dynamic>{
      'league': instance.league,
      'season': instance.season,
      'teams': instance.teams,
    };
