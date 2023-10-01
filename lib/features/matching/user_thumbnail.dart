import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tokyo_flutter_hack_demo/common/styles/app_color.dart';

class UserThumbnail extends StatelessWidget {
  final String url;
  const UserThumbnail({required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: AppColor.primary,
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        clipBehavior: Clip.antiAlias,
        child: CachedNetworkImage(
          imageUrl: url,
          width: 36,
          height: 36,
        ),
      ),
    );
  }
}
