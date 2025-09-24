import 'package:freezed_annotation/freezed_annotation.dart';

part 'pick.freezed.dart';
part 'pick.g.dart';

enum PickResult { PENDING, WIN, LOSE, PUSH }

@freezed
abstract class Pick with _$Pick {
  const factory Pick({
    required String id,
    required String leagueId,
    required String userId,
    required int week,
    required String teamId,
    required String madeAtIso,
    required bool locked,
    PickResult? result,
  }) = _Pick;

  factory Pick.fromJson(Map<String, dynamic> json) => _$PickFromJson(json);
}

