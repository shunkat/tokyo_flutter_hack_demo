import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokyo_flutter_hack_demo/common/components/distance_tag.dart';
import 'package:tokyo_flutter_hack_demo/common/components/status_toggle.dart';
import 'package:tokyo_flutter_hack_demo/common/styles/app_color.dart';
import 'package:tokyo_flutter_hack_demo/common/styles/app_text_style.dart';

class ProfilePage extends ConsumerWidget {
  final String name;
  final String avatarUrl;
  final String comment;
  final String distance;
  final int howStrong;

  const ProfilePage({
    super.key,
    required this.name,
    required this.avatarUrl,
    required this.comment,
    required this.distance,
    required this.howStrong,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('プロフィール'),
          actions: const [
            StatusToggle(),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  Text(name, style: AppTextStyle.noto24Mediumn),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColor.grey100,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      avatarUrl,
                      width: MediaQuery.of(context).size.width - 28,
                      height: MediaQuery.of(context).size.width - 28,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColor.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DistanceTag(distance: distance),
                        const SizedBox(height: 6),
                        Text(comment, style: AppTextStyle.noto14Medium),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: howStrong,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2),
                    itemBuilder: (_, i) {
                      return Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Image.asset("assets/images/lemon_can.png"),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
