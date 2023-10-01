// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'matching.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Matching _$MatchingFromJson(Map<String, dynamic> json) {
  return _Matching.fromJson(json);
}

/// @nodoc
mixin _$Matching {
  String get id => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  MatchingStatus get status => throw _privateConstructorUsedError;
  List<String> get candidates => throw _privateConstructorUsedError;
  List<String> get participants => throw _privateConstructorUsedError;
  List<String> get canceled => throw _privateConstructorUsedError;
  List<UserSummary> get userSummaries => throw _privateConstructorUsedError;
  DateTime get lastJoinAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchingCopyWith<Matching> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchingCopyWith<$Res> {
  factory $MatchingCopyWith(Matching value, $Res Function(Matching) then) =
      _$MatchingCopyWithImpl<$Res, Matching>;
  @useResult
  $Res call(
      {String id,
      String createdBy,
      MatchingStatus status,
      List<String> candidates,
      List<String> participants,
      List<String> canceled,
      List<UserSummary> userSummaries,
      DateTime lastJoinAt});
}

/// @nodoc
class _$MatchingCopyWithImpl<$Res, $Val extends Matching>
    implements $MatchingCopyWith<$Res> {
  _$MatchingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdBy = null,
    Object? status = null,
    Object? candidates = null,
    Object? participants = null,
    Object? canceled = null,
    Object? userSummaries = null,
    Object? lastJoinAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MatchingStatus,
      candidates: null == candidates
          ? _value.candidates
          : candidates // ignore: cast_nullable_to_non_nullable
              as List<String>,
      participants: null == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      canceled: null == canceled
          ? _value.canceled
          : canceled // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userSummaries: null == userSummaries
          ? _value.userSummaries
          : userSummaries // ignore: cast_nullable_to_non_nullable
              as List<UserSummary>,
      lastJoinAt: null == lastJoinAt
          ? _value.lastJoinAt
          : lastJoinAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchingImplCopyWith<$Res>
    implements $MatchingCopyWith<$Res> {
  factory _$$MatchingImplCopyWith(
          _$MatchingImpl value, $Res Function(_$MatchingImpl) then) =
      __$$MatchingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String createdBy,
      MatchingStatus status,
      List<String> candidates,
      List<String> participants,
      List<String> canceled,
      List<UserSummary> userSummaries,
      DateTime lastJoinAt});
}

/// @nodoc
class __$$MatchingImplCopyWithImpl<$Res>
    extends _$MatchingCopyWithImpl<$Res, _$MatchingImpl>
    implements _$$MatchingImplCopyWith<$Res> {
  __$$MatchingImplCopyWithImpl(
      _$MatchingImpl _value, $Res Function(_$MatchingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdBy = null,
    Object? status = null,
    Object? candidates = null,
    Object? participants = null,
    Object? canceled = null,
    Object? userSummaries = null,
    Object? lastJoinAt = null,
  }) {
    return _then(_$MatchingImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MatchingStatus,
      candidates: null == candidates
          ? _value._candidates
          : candidates // ignore: cast_nullable_to_non_nullable
              as List<String>,
      participants: null == participants
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      canceled: null == canceled
          ? _value._canceled
          : canceled // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userSummaries: null == userSummaries
          ? _value._userSummaries
          : userSummaries // ignore: cast_nullable_to_non_nullable
              as List<UserSummary>,
      lastJoinAt: null == lastJoinAt
          ? _value.lastJoinAt
          : lastJoinAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchingImpl extends _Matching with DiagnosticableTreeMixin {
  const _$MatchingImpl(
      {required this.id,
      required this.createdBy,
      required this.status,
      required final List<String> candidates,
      required final List<String> participants,
      required final List<String> canceled,
      required final List<UserSummary> userSummaries,
      required this.lastJoinAt})
      : _candidates = candidates,
        _participants = participants,
        _canceled = canceled,
        _userSummaries = userSummaries,
        super._();

  factory _$MatchingImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchingImplFromJson(json);

  @override
  final String id;
  @override
  final String createdBy;
  @override
  final MatchingStatus status;
  final List<String> _candidates;
  @override
  List<String> get candidates {
    if (_candidates is EqualUnmodifiableListView) return _candidates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_candidates);
  }

  final List<String> _participants;
  @override
  List<String> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  final List<String> _canceled;
  @override
  List<String> get canceled {
    if (_canceled is EqualUnmodifiableListView) return _canceled;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_canceled);
  }

  final List<UserSummary> _userSummaries;
  @override
  List<UserSummary> get userSummaries {
    if (_userSummaries is EqualUnmodifiableListView) return _userSummaries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userSummaries);
  }

  @override
  final DateTime lastJoinAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Matching(id: $id, createdBy: $createdBy, status: $status, candidates: $candidates, participants: $participants, canceled: $canceled, userSummaries: $userSummaries, lastJoinAt: $lastJoinAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Matching'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('createdBy', createdBy))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('candidates', candidates))
      ..add(DiagnosticsProperty('participants', participants))
      ..add(DiagnosticsProperty('canceled', canceled))
      ..add(DiagnosticsProperty('userSummaries', userSummaries))
      ..add(DiagnosticsProperty('lastJoinAt', lastJoinAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._candidates, _candidates) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants) &&
            const DeepCollectionEquality().equals(other._canceled, _canceled) &&
            const DeepCollectionEquality()
                .equals(other._userSummaries, _userSummaries) &&
            (identical(other.lastJoinAt, lastJoinAt) ||
                other.lastJoinAt == lastJoinAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdBy,
      status,
      const DeepCollectionEquality().hash(_candidates),
      const DeepCollectionEquality().hash(_participants),
      const DeepCollectionEquality().hash(_canceled),
      const DeepCollectionEquality().hash(_userSummaries),
      lastJoinAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchingImplCopyWith<_$MatchingImpl> get copyWith =>
      __$$MatchingImplCopyWithImpl<_$MatchingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchingImplToJson(
      this,
    );
  }
}

abstract class _Matching extends Matching {
  const factory _Matching(
      {required final String id,
      required final String createdBy,
      required final MatchingStatus status,
      required final List<String> candidates,
      required final List<String> participants,
      required final List<String> canceled,
      required final List<UserSummary> userSummaries,
      required final DateTime lastJoinAt}) = _$MatchingImpl;
  const _Matching._() : super._();

  factory _Matching.fromJson(Map<String, dynamic> json) =
      _$MatchingImpl.fromJson;

  @override
  String get id;
  @override
  String get createdBy;
  @override
  MatchingStatus get status;
  @override
  List<String> get candidates;
  @override
  List<String> get participants;
  @override
  List<String> get canceled;
  @override
  List<UserSummary> get userSummaries;
  @override
  DateTime get lastJoinAt;
  @override
  @JsonKey(ignore: true)
  _$$MatchingImplCopyWith<_$MatchingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserSummary _$UserSummaryFromJson(Map<String, dynamic> json) {
  return _UserSummary.fromJson(json);
}

/// @nodoc
mixin _$UserSummary {
  String get id => throw _privateConstructorUsedError;
  String get avatarUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserSummaryCopyWith<UserSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSummaryCopyWith<$Res> {
  factory $UserSummaryCopyWith(
          UserSummary value, $Res Function(UserSummary) then) =
      _$UserSummaryCopyWithImpl<$Res, UserSummary>;
  @useResult
  $Res call({String id, String avatarUrl});
}

/// @nodoc
class _$UserSummaryCopyWithImpl<$Res, $Val extends UserSummary>
    implements $UserSummaryCopyWith<$Res> {
  _$UserSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? avatarUrl = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserSummaryImplCopyWith<$Res>
    implements $UserSummaryCopyWith<$Res> {
  factory _$$UserSummaryImplCopyWith(
          _$UserSummaryImpl value, $Res Function(_$UserSummaryImpl) then) =
      __$$UserSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String avatarUrl});
}

/// @nodoc
class __$$UserSummaryImplCopyWithImpl<$Res>
    extends _$UserSummaryCopyWithImpl<$Res, _$UserSummaryImpl>
    implements _$$UserSummaryImplCopyWith<$Res> {
  __$$UserSummaryImplCopyWithImpl(
      _$UserSummaryImpl _value, $Res Function(_$UserSummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? avatarUrl = null,
  }) {
    return _then(_$UserSummaryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSummaryImpl extends _UserSummary with DiagnosticableTreeMixin {
  const _$UserSummaryImpl({required this.id, required this.avatarUrl})
      : super._();

  factory _$UserSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSummaryImplFromJson(json);

  @override
  final String id;
  @override
  final String avatarUrl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserSummary(id: $id, avatarUrl: $avatarUrl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserSummary'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('avatarUrl', avatarUrl));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, avatarUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSummaryImplCopyWith<_$UserSummaryImpl> get copyWith =>
      __$$UserSummaryImplCopyWithImpl<_$UserSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSummaryImplToJson(
      this,
    );
  }
}

abstract class _UserSummary extends UserSummary {
  const factory _UserSummary(
      {required final String id,
      required final String avatarUrl}) = _$UserSummaryImpl;
  const _UserSummary._() : super._();

  factory _UserSummary.fromJson(Map<String, dynamic> json) =
      _$UserSummaryImpl.fromJson;

  @override
  String get id;
  @override
  String get avatarUrl;
  @override
  @JsonKey(ignore: true)
  _$$UserSummaryImplCopyWith<_$UserSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
