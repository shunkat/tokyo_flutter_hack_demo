// 保存時の自動整形でfoundationが消えないように警告を消している
// ignore: unused_import, directives_ordering
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokyo_flutter_hack_demo/utils/AppPreference.dart';

part 'matching.freezed.dart';
part 'matching.g.dart';

final relatedMatchingStreamProvider =
    StreamProvider.autoDispose<Matching?>((ref) {
  final userId = ref.watch(userIdProvider);
  final listener = FirebaseFirestore.instance
      .collection('matchings')
      .where("status", isEqualTo: "pending")
      .where('candidates', arrayContains: userId)
      // なぜか動かない
      // .where(
      //   'lastJoinAt',
      //   isLessThan: Timestamp.fromDate(DateTime.now().subtract(
      //     const Duration(seconds: 10000000),
      //   )),
      // )
      .limit(1)
      .snapshots();

  return listener.map((event) {
    print(event.docs);
    final list = event.docs.map((e) => Matching.fromJson(e.data())).toList();
    return list.isEmpty ? null : list.first;
  });
});

final relatedMatchingProvider = StateProvider.autoDispose<Matching?>((ref) {
  final stream = ref.watch(relatedMatchingStreamProvider);
  return stream.when(
    data: (data) => data,
    loading: () => null,
    error: (e, s) {
      print(e);
      print(s);
      return null;
    },
  );
});

enum MatchingStatus {
  pending,
  complete,
}

@freezed
class Matching with _$Matching {
  const Matching._();
  const factory Matching({
    required String id,
    required String createdBy,
    required MatchingStatus status,
    required List<String> candidates,
    required List<String> participants,
    required List<String> canceled,
    required List<UserSummary> userSummaries,
    required DateTime lastJoinAt,
  }) = _Matching;

  factory Matching.fromJson(Map<String, dynamic> json) =>
      _$MatchingFromJson(json);

  Map<String, dynamic> toFirestoreJson() {
    return {
      ...toJson(),
      "userSummaries": userSummaries.map((e) => e.toFirestoreJson()).toList(),
    };
  }
}

@freezed
class UserSummary with _$UserSummary {
  const UserSummary._();
  const factory UserSummary({
    required String id,
    required String avatarUrl,
  }) = _UserSummary;

  factory UserSummary.fromJson(Map<String, dynamic> json) =>
      _$UserSummaryFromJson(json);

  Map<String, dynamic> toFirestoreJson() {
    return {
      ...toJson(),
    };
  }
}
