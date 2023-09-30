// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  String get avatarUrl => throw _privateConstructorUsedError;
  int get howStrong => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String? get fcmToken => throw _privateConstructorUsedError;
  List<NearbyUser> get nearbyUserDetails => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String id,
      String name,
      String comment,
      String avatarUrl,
      int howStrong,
      double latitude,
      double longitude,
      bool isActive,
      String? fcmToken,
      List<NearbyUser> nearbyUserDetails});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? comment = null,
    Object? avatarUrl = null,
    Object? howStrong = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? isActive = null,
    Object? fcmToken = freezed,
    Object? nearbyUserDetails = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      howStrong: null == howStrong
          ? _value.howStrong
          : howStrong // ignore: cast_nullable_to_non_nullable
              as int,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
      nearbyUserDetails: null == nearbyUserDetails
          ? _value.nearbyUserDetails
          : nearbyUserDetails // ignore: cast_nullable_to_non_nullable
              as List<NearbyUser>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String comment,
      String avatarUrl,
      int howStrong,
      double latitude,
      double longitude,
      bool isActive,
      String? fcmToken,
      List<NearbyUser> nearbyUserDetails});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? comment = null,
    Object? avatarUrl = null,
    Object? howStrong = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? isActive = null,
    Object? fcmToken = freezed,
    Object? nearbyUserDetails = null,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      howStrong: null == howStrong
          ? _value.howStrong
          : howStrong // ignore: cast_nullable_to_non_nullable
              as int,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
      nearbyUserDetails: null == nearbyUserDetails
          ? _value._nearbyUserDetails
          : nearbyUserDetails // ignore: cast_nullable_to_non_nullable
              as List<NearbyUser>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl extends _User {
  const _$UserImpl(
      {required this.id,
      required this.name,
      required this.comment,
      required this.avatarUrl,
      required this.howStrong,
      required this.latitude,
      required this.longitude,
      required this.isActive,
      required this.fcmToken,
      required final List<NearbyUser> nearbyUserDetails})
      : _nearbyUserDetails = nearbyUserDetails,
        super._();

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String comment;
  @override
  final String avatarUrl;
  @override
  final int howStrong;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final bool isActive;
  @override
  final String? fcmToken;
  final List<NearbyUser> _nearbyUserDetails;
  @override
  List<NearbyUser> get nearbyUserDetails {
    if (_nearbyUserDetails is EqualUnmodifiableListView)
      return _nearbyUserDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nearbyUserDetails);
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, comment: $comment, avatarUrl: $avatarUrl, howStrong: $howStrong, latitude: $latitude, longitude: $longitude, isActive: $isActive, fcmToken: $fcmToken, nearbyUserDetails: $nearbyUserDetails)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.howStrong, howStrong) ||
                other.howStrong == howStrong) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken) &&
            const DeepCollectionEquality()
                .equals(other._nearbyUserDetails, _nearbyUserDetails));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      comment,
      avatarUrl,
      howStrong,
      latitude,
      longitude,
      isActive,
      fcmToken,
      const DeepCollectionEquality().hash(_nearbyUserDetails));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User extends User {
  const factory _User(
      {required final String id,
      required final String name,
      required final String comment,
      required final String avatarUrl,
      required final int howStrong,
      required final double latitude,
      required final double longitude,
      required final bool isActive,
      required final String? fcmToken,
      required final List<NearbyUser> nearbyUserDetails}) = _$UserImpl;
  const _User._() : super._();

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get comment;
  @override
  String get avatarUrl;
  @override
  int get howStrong;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  bool get isActive;
  @override
  String? get fcmToken;
  @override
  List<NearbyUser> get nearbyUserDetails;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NearbyUser _$NearbyUserFromJson(Map<String, dynamic> json) {
  return _NearbyUser.fromJson(json);
}

/// @nodoc
mixin _$NearbyUser {
  String get name => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  String get avatarUrl => throw _privateConstructorUsedError;
  int get howStrong => throw _privateConstructorUsedError;
  String get distance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NearbyUserCopyWith<NearbyUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NearbyUserCopyWith<$Res> {
  factory $NearbyUserCopyWith(
          NearbyUser value, $Res Function(NearbyUser) then) =
      _$NearbyUserCopyWithImpl<$Res, NearbyUser>;
  @useResult
  $Res call(
      {String name,
      String comment,
      String avatarUrl,
      int howStrong,
      String distance});
}

/// @nodoc
class _$NearbyUserCopyWithImpl<$Res, $Val extends NearbyUser>
    implements $NearbyUserCopyWith<$Res> {
  _$NearbyUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? comment = null,
    Object? avatarUrl = null,
    Object? howStrong = null,
    Object? distance = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      howStrong: null == howStrong
          ? _value.howStrong
          : howStrong // ignore: cast_nullable_to_non_nullable
              as int,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NearbyUserImplCopyWith<$Res>
    implements $NearbyUserCopyWith<$Res> {
  factory _$$NearbyUserImplCopyWith(
          _$NearbyUserImpl value, $Res Function(_$NearbyUserImpl) then) =
      __$$NearbyUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String comment,
      String avatarUrl,
      int howStrong,
      String distance});
}

/// @nodoc
class __$$NearbyUserImplCopyWithImpl<$Res>
    extends _$NearbyUserCopyWithImpl<$Res, _$NearbyUserImpl>
    implements _$$NearbyUserImplCopyWith<$Res> {
  __$$NearbyUserImplCopyWithImpl(
      _$NearbyUserImpl _value, $Res Function(_$NearbyUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? comment = null,
    Object? avatarUrl = null,
    Object? howStrong = null,
    Object? distance = null,
  }) {
    return _then(_$NearbyUserImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      howStrong: null == howStrong
          ? _value.howStrong
          : howStrong // ignore: cast_nullable_to_non_nullable
              as int,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NearbyUserImpl extends _NearbyUser {
  const _$NearbyUserImpl(
      {required this.name,
      required this.comment,
      required this.avatarUrl,
      required this.howStrong,
      required this.distance})
      : super._();

  factory _$NearbyUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$NearbyUserImplFromJson(json);

  @override
  final String name;
  @override
  final String comment;
  @override
  final String avatarUrl;
  @override
  final int howStrong;
  @override
  final String distance;

  @override
  String toString() {
    return 'NearbyUser(name: $name, comment: $comment, avatarUrl: $avatarUrl, howStrong: $howStrong, distance: $distance)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NearbyUserImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.howStrong, howStrong) ||
                other.howStrong == howStrong) &&
            (identical(other.distance, distance) ||
                other.distance == distance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, comment, avatarUrl, howStrong, distance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NearbyUserImplCopyWith<_$NearbyUserImpl> get copyWith =>
      __$$NearbyUserImplCopyWithImpl<_$NearbyUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NearbyUserImplToJson(
      this,
    );
  }
}

abstract class _NearbyUser extends NearbyUser {
  const factory _NearbyUser(
      {required final String name,
      required final String comment,
      required final String avatarUrl,
      required final int howStrong,
      required final String distance}) = _$NearbyUserImpl;
  const _NearbyUser._() : super._();

  factory _NearbyUser.fromJson(Map<String, dynamic> json) =
      _$NearbyUserImpl.fromJson;

  @override
  String get name;
  @override
  String get comment;
  @override
  String get avatarUrl;
  @override
  int get howStrong;
  @override
  String get distance;
  @override
  @JsonKey(ignore: true)
  _$$NearbyUserImplCopyWith<_$NearbyUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
