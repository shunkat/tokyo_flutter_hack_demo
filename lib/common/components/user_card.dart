import 'package:flutter/material.dart';
import 'package:tokyo_flutter_hack_demo/common/components/distance_tag.dart';
import 'package:tokyo_flutter_hack_demo/common/styles/app_color.dart';
import 'package:tokyo_flutter_hack_demo/pages/profile_page.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final String distance;
  final String comment;
  final int howStrong;
  const UserCard({
    required this.name,
    required this.imagePath,
    required this.distance,
    required this.comment,
    required this.howStrong,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.gray200,
            spreadRadius: 4,
            blurRadius: 10,
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(imagePath),
                    radius: 50,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(
                          name: name,
                          avatarUrl: imagePath,
                          comment: comment,
                          distance: distance,
                          howStrong: howStrong,
                        ),
                      ),
                    );
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8.0),
                        Text(comment),
                        const SizedBox(height: 8.0),
                        DistanceTag(distance: distance),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 6,
            right: 0,
            child: Row(
              children: List.generate(
                howStrong > 5 ? 5 : howStrong,
                (index) =>
                    Image.asset('assets/images/lemon_can.png', width: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
