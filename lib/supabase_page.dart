import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tokyo_flutter_hack_demo/common/components/distance_tag.dart';
import 'package:tokyo_flutter_hack_demo/pages/profile_page.dart';

class SupabasePage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = '9pJDDsSPSslFsFSLjlYO';

  SupabasePage({super.key}); // 仮のID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ハーフモーダルの仮実装'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'mapをここに表示',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
              child: DraggableScrollableSheet(
                initialChildSize: 0.2,
                minChildSize: 0.1,
                maxChildSize: 0.8,
                snap: true,
                snapSizes: const [0.1, 0.5, 0.8],
                builder:
                    (BuildContext context, ScrollController scrollController) {
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
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: _firestore
                          .collection('users')
                          .doc(userId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        // :todo なんか変だけど一瞬だから見逃してる、綺麗なローディングのイメージがあればあとで実装しましょう
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }

                        var userDetails = snapshot.data!['nearbyUserDetails'];

                        return ListView.builder(
                          controller: scrollController,
                          itemCount: userDetails.length,
                          itemBuilder: (BuildContext context, int index) {
                            var user = userDetails[index];
                            return _userCard(
                              user['name'],
                              user['avatarUrl'],
                              user['distance'],
                              user['comment'],
                              user['howStrong'],
                              context,
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userCard(String name, String imagePath, String distance,
      String comment, int howStrong, BuildContext context) {
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
