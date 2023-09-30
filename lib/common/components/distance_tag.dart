import 'package:flutter/material.dart';

class DistanceTag extends StatelessWidget {
  final String distance;
  const DistanceTag({required this.distance, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.yellow,
      ),
      padding:
          const EdgeInsets.symmetric(horizontal: 4.0), // オプショナル: 追加のパディングを適用
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.map_outlined, size: 16.0, color: Colors.grey[800]),
          Text(distance),
        ],
      ),
    );
  }
}
