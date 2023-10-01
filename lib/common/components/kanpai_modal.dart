import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokyo_flutter_hack_demo/common/styles/app_color.dart';

class KanpaiModal extends ConsumerWidget {
  const KanpaiModal({
    super.key,
    required this.message,
    required this.avatarUrls,
    required this.onPop,
  });

  final String message;
  final List<String> avatarUrls;
  final VoidCallback onPop;

  static show(BuildContext context,
      {required List<String> avatarUrls, required VoidCallback onPop}) {
    // avatarUrlsの先頭3つを取得
    final limitedAvatarUrls = avatarUrls.take(3).toList();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return KanpaiModal(
            message: "乾杯！",
            avatarUrls: limitedAvatarUrls,
            onPop: onPop,
          );
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: AppColor.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    onPop.call();
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Image.asset(
                    "assets/images/kanpai_ribon.png",
                    width: 279,
                    height: 53,
                  )),
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/images/kanpai_animation.gif',
                width: 248,
                height: 266,
                fit: BoxFit.fitHeight,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  color: AppColor.gray200,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (final avatarUrl in avatarUrls)
                      Container(
                        // 2px border
                        width: 60,
                        height: 60,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: AppColor.primary,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(avatarUrl),
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
