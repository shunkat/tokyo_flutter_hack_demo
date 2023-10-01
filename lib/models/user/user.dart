// 保存時の自動整形でfoundationが消えないように警告を消している
// ignore: unused_import, directives_ordering
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokyo_flutter_hack_demo/utils/AppPreference.dart';
import 'package:tokyo_flutter_hack_demo/utils/calculateDistance.dart';

part 'user.freezed.dart';
part 'user.g.dart';

final currentUserStreamProvider = StreamProvider.autoDispose<User?>((ref) {
  final userId = ref.watch(userIdProvider);
  final listener =
      FirebaseFirestore.instance.collection('users').doc(userId).snapshots();
  return listener.map(
    (event) => User.fromJson(event.data()!),
  );
});

final currentUserProvider = Provider.autoDispose<User?>((ref) {
  final stream = ref.watch(currentUserStreamProvider);
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

final matchiableUsersProvider = StateProvider.autoDispose<List<User>>((ref) {
  final allUsers = ref.watch(allUsersProvider);
  final currentUser = ref.watch(currentUserProvider);

  if (allUsers == null || currentUser == null) {
    return [];
  }

  final machiables = allUsers.where((user) {
    if (user.id == currentUser.id) return false;

    final distance = calculateDistance(user.latitude, user.longitude,
        currentUser.latitude, currentUser.longitude);
    return distance < 0.05;
  });

  return machiables.toList();
});

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
