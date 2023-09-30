import 'package:flutter/material.dart';
import 'package:tokyo_flutter_hack_demo/common/components/distance_tag.dart';
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
      margin: const EdgeInsets.all(8.0),
      color: Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
            top: 10,
            right: 10,
            child: Row(
              children: List.generate(
                howStrong,
                (index) =>
                    Image.asset('assets/images/can.png', width: 20, height: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
