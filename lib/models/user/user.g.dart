// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      isActive: json['isActive'] as bool,
      fcmToken: json['fcmToken'] as String?,
      nearbyUserIds: (json['nearbyUserIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'isActive': instance.isActive,
      'fcmToken': instance.fcmToken,
      'nearbyUserIds': instance.nearbyUserIds,
    };
