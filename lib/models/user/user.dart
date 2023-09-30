// 保存時の自動整形でfoundationが消えないように警告を消している
// ignore: unused_import, directives_ordering
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// import 'package:user_app/models/converters/timestamp.dart';

part 'user.freezed.dart';
part 'user.g.dart';

final allUsersStreamProvider = StreamProvider.autoDispose<List<User>>((ref) {
  final listener = FirebaseFirestore.instance.collection('users').snapshots();
  return listener.map(
    (event) => event.docs.map((e) => User.fromJson(e.data())).toList(),
  );
});

final allUsersProvider = Provider.autoDispose<List<User>?>((ref) {
  final stream = ref.watch(allUsersStreamProvider);
  return stream.when(
    data: (data) {
      return data;
    },
    loading: () => null,
    error: (e, s) {
      debugPrint("error");
      debugPrint(e.toString());
      return null;
    },
  );
});

@freezed
class User with _$User {
  const User._();
  const factory User({
    required String id,
    required String name,
    required String comment,
    required String avatarUrl,
    required int howStrong,
    required double latitude,
    required double longitude,
    required bool isActive,
    required String? fcmToken,
    required List<NearbyUser> nearbyUserDetails,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toFirestoreJson() {
    return {
      ...toJson(),
    };
  }
}

@freezed
class NearbyUser with _$NearbyUser {
  const NearbyUser._();
  const factory NearbyUser({
    required String name,
    required String comment,
    required String avatarUrl,
    required int howStrong,
    required String distance,
  }) = _NearbyUser;

  factory NearbyUser.fromJson(Map<String, dynamic> json) =>
      _$NearbyUserFromJson(json);

  Map<String, dynamic> toFirestoreJson() {
    return {
      ...toJson(),
    };
  }
}
