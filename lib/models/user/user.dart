// 保存時の自動整形でfoundationが消えないように警告を消している
// ignore: unused_import, directives_ordering
import 'package:cloud_firestore/cloud_firestore.dart';
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
      print("data");
      return data;
    },
    loading: () {
      print("loading");
      return null;
    },
    error: (e, s) {
      print("error");
      print(e);
      return null;
    },
  );
});

@freezed
class User with _$User {
  const User._();
  const factory User({
    required String name,
    required String avatarUrl,
    required double latitude,
    required double longitude,
    required bool isActive,
    required String? fcmToken,
    required List<String> nearbyUserIds,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toFirestoreJson() {
    return {
      ...toJson(),
    };
  }
}
