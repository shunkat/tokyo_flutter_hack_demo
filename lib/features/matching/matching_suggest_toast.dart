import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokyo_flutter_hack_demo/common/components/app_secondary_button.dart';
import 'package:tokyo_flutter_hack_demo/common/styles/app_color.dart';
import 'package:tokyo_flutter_hack_demo/features/matching/user_thumbnail_list.dart';
import 'package:tokyo_flutter_hack_demo/models/matching/matching.dart';
import 'package:tokyo_flutter_hack_demo/models/user/user.dart';
import 'package:tokyo_flutter_hack_demo/utils/AppPreference.dart';

class MatchingSuggestToast extends ConsumerWidget {
  const MatchingSuggestToast({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchiableUsers = ref.watch(matchiableUsersProvider);
    final matching = ref.watch(relatedMatchingProvider);

    return Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        height: 56,
        width: 200,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(
              builder: (context) {
                return Expanded(
                    child: UserThumbnailList(
                        urls:
                            matchiableUsers.map((e) => e.avatarUrl).toList()));
              },
            ),
            const Text("近くのメンバーがいます！"),
            SizedBox(
              width: 60,
              height: 24,
              child: AppSecondaryButton(
                onTap: () {
                  final userId = ref.read(userIdProvider);
                  if (userId == null) return;
                  final doc =
                      FirebaseFirestore.instance.collection("matchings").doc();
                  final currentUser = ref.read(currentUserProvider);

                  final newMatching = Matching(
                    id: doc.id,
                    createdBy: userId,
                    status: MatchingStatus.pending,
                    userSummaries: matchiableUsers
                            .map((e) =>
                                UserSummary(id: e.id, avatarUrl: e.avatarUrl))
                            .toList() +
                        [
                          UserSummary(
                              id: userId, avatarUrl: currentUser!.avatarUrl)
                        ],
                    candidates:
                        matchiableUsers.map((e) => e.id).toList() + [userId],
                    participants: [userId],
                    canceled: [],
                    lastJoinAt: DateTime.now(),
                  );

                  doc.set(newMatching.toFirestoreJson());
                },
                text: '誘う',
                isDisabled: matching != null,
              ),
            ),
          ],
        ));
  }
}
