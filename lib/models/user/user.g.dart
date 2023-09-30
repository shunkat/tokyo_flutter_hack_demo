// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      comment: json['comment'] as String,
      avatarUrl: json['avatarUrl'] as String,
      howStrong: json['howStrong'] as int,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      isActive: json['isActive'] as bool,
      fcmToken: json['fcmToken'] as String?,
      nearbyUserDetails: (json['nearbyUserDetails'] as List<dynamic>)
          .map((e) => NearbyUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'comment': instance.comment,
      'avatarUrl': instance.avatarUrl,
      'howStrong': instance.howStrong,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'isActive': instance.isActive,
      'fcmToken': instance.fcmToken,
      'nearbyUserDetails': instance.nearbyUserDetails,
    };

_$NearbyUserImpl _$$NearbyUserImplFromJson(Map<String, dynamic> json) =>
    _$NearbyUserImpl(
      name: json['name'] as String,
      comment: json['comment'] as String,
      avatarUrl: json['avatarUrl'] as String,
      howStrong: json['howStrong'] as int,
      distance: json['distance'] as String,
    );

Map<String, dynamic> _$$NearbyUserImplToJson(_$NearbyUserImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'comment': instance.comment,
      'avatarUrl': instance.avatarUrl,
      'howStrong': instance.howStrong,
      'distance': instance.distance,
    };
