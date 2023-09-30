import 'package:flutter/material.dart';
import 'package:tokyo_flutter_hack_demo/common/components/user_card.dart';
import 'package:tokyo_flutter_hack_demo/models/user/user.dart';

class NearbyUserList extends StatelessWidget {
  final List<NearbyUser> users;
  final ScrollController scrollController;
  const NearbyUserList(
      {required this.users, required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 4,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListView.builder(
        itemCount: users.length,
        controller: scrollController,
        itemBuilder: (BuildContext context, int index) {
          var user = users[index];
          return UserCard(
            name: user.name,
            imagePath: user.avatarUrl,
            distance: user.distance,
            comment: user.comment,
            howStrong: user.howStrong,
          );
        },
      ),
    );
  }
}
