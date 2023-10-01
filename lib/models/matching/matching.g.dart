// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matching.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MatchingImpl _$$MatchingImplFromJson(Map<String, dynamic> json) =>
    _$MatchingImpl(
      id: json['id'] as String,
      createdBy: json['createdBy'] as String,
      status: $enumDecode(_$MatchingStatusEnumMap, json['status']),
      candidates: (json['candidates'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      participants: (json['participants'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      canceled:
          (json['canceled'] as List<dynamic>).map((e) => e as String).toList(),
      userSummaries: (json['userSummaries'] as List<dynamic>)
          .map((e) => UserSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastJoinAt: DateTime.parse(json['lastJoinAt'] as String),
    );

Map<String, dynamic> _$$MatchingImplToJson(_$MatchingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdBy': instance.createdBy,
      'status': _$MatchingStatusEnumMap[instance.status]!,
      'candidates': instance.candidates,
      'participants': instance.participants,
      'canceled': instance.canceled,
      'userSummaries': instance.userSummaries,
      'lastJoinAt': instance.lastJoinAt.toIso8601String(),
    };

const _$MatchingStatusEnumMap = {
  MatchingStatus.pending: 'pending',
  MatchingStatus.complete: 'complete',
};

_$UserSummaryImpl _$$UserSummaryImplFromJson(Map<String, dynamic> json) =>
    _$UserSummaryImpl(
      id: json['id'] as String,
      avatarUrl: json['avatarUrl'] as String,
    );

Map<String, dynamic> _$$UserSummaryImplToJson(_$UserSummaryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avatarUrl': instance.avatarUrl,
    };
