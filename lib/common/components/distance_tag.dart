import 'package:flutter/material.dart';
import 'package:tokyo_flutter_hack_demo/common/styles/app_text_style.dart';

class DistanceTag extends StatelessWidget {
  final String distance;
  const DistanceTag({required this.distance, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.yellow,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.pin_drop_outlined, size: 16.0, color: Colors.grey[800]),
          const SizedBox(width: 2),
          Padding(
            padding: EdgeInsets.only(bottom: 1),
            child: Text(
              distance,
              style: AppTextStyle.noto12medium,
            ),
          )
        ],
      ),
    );
  }
}
