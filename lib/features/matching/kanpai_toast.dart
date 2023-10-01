import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokyo_flutter_hack_demo/common/components/app_secondary_button.dart';
import 'package:tokyo_flutter_hack_demo/features/matching/user_thumbnail_list.dart';
import 'package:tokyo_flutter_hack_demo/models/matching/matching.dart';
import 'package:tokyo_flutter_hack_demo/utils/AppPreference.dart';

class KanpaiToast extends HookConsumerWidget {
  const KanpaiToast({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);
    final matching = ref.watch(relatedMatchingProvider);

    final urls = matching?.userSummaries
            .where((summary) => matching.participants.contains(summary.id))
            .map((e) => e.avatarUrl)
            .toList() ??
        [];

    if (matching == null) return Container();

    final remainnigTime = useState<int>(10);

    useEffect(() {
      print(matching);
      final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        final diff = DateTime.now().difference(matching.lastJoinAt);
        remainnigTime.value = 10 - diff.inSeconds;
        if (remainnigTime.value <= 0) {
          if (matching.participants.length == 1) {
            // 不成立
            print("不成立");
          } else if (matching.participants.length >= 2) {
            // 成立
            print("成立");
            if (userId == null) return;
            FirebaseFirestore.instance.collection('users').doc(userId).update(
              {
                'isActive': false,
              },
            );
          }

          if (matching.createdBy == ref.read(userIdProvider)) {
            Future.delayed(const Duration(seconds: 3), () {
              FirebaseFirestore.instance
                  .collection('matchings')
                  .doc(matching.id)
                  .update(
                {
                  'status': MatchingStatus.complete.name,
                },
              );
            });
          }

          timer.cancel();
        }
      });

      return () {
        timer.cancel();
      };
    }, [matching]);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Row(
            children: [
              UserThumbnailList(urls: urls),
              Text(remainnigTime.value.toString()),
            ],
          ),
          Row(
            children: [
              const Spacer(),
              SizedBox(
                height: 24,
                width: 65,
                child: AppSecondaryButton(
                    onTap: () {
                      final userId = ref.read(userIdProvider);
                      if (userId == null) return;

                      FirebaseFirestore.instance
                          .collection('matchings')
                          .doc(matching.id)
                          .update({
                        'participants': FieldValue.arrayUnion([userId]),
                        'lastJoinAt': DateTime.now(),
                      });
                    },
                    text: "乾杯！"),
              ),
            ],
          )
        ],
      ),
    );
  }
}