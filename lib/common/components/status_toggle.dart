import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokyo_flutter_hack_demo/common/styles/app_color.dart';
import 'package:tokyo_flutter_hack_demo/models/user/user.dart';

class StatusToggle extends ConsumerWidget {
  const StatusToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    if (user == null) {
      return Container();
    }

    return Switch(
      value: user.isActive,
      activeColor: AppColor.white,
      activeTrackColor: AppColor.primary,
      inactiveThumbColor: AppColor.white,
      inactiveTrackColor: AppColor.grey100,
      onChanged: (_) {
        FirebaseFirestore.instance.collection('users').doc(user.id).update({
          'isActive': !user.isActive,
        });
      },
    );
  }
}
