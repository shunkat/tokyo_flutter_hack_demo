import 'package:flutter/material.dart';
import 'package:tokyo_flutter_hack_demo/features/matching/user_thumbnail.dart';

class UserThumbnailList extends StatelessWidget {
  final List<String> urls;
  const UserThumbnailList({required this.urls, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ...urls
            .map(
              (url) => Positioned(
                left: 0,
                child: UserThumbnail(url: urls[0]),
              ),
            )
            .toList(),
      ],
    );
  }
}
