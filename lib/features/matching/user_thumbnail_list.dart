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
            .asMap()
            .entries
            .map(
              (entry) => Positioned(
                left: entry.key * 20.0,
                child: UserThumbnail(url: entry.value),
              ),
            )
            .toList(),
      ],
    );
  }
}
