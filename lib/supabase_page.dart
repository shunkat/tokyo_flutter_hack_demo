import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SupabasePage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = '9pJDDsSPSslFsFSLjlYO'; // 仮のID

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
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: DraggableScrollableSheet(
                initialChildSize: 0.2,
                minChildSize: 0.1,
                maxChildSize: 0.8,
                snap: true,
                snapSizes: const [0.1, 0.5, 0.8],
                builder: (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 4,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: _firestore.collection('users').doc(userId).snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return CircularProgressIndicator();

                        var userDetails = snapshot.data!['nearbyUserDetails'];

                        return ListView.builder(
                          controller: scrollController,
                          itemCount: userDetails.length,
                          itemBuilder: (BuildContext context, int index) {
                            var user = userDetails[index];
                            return _userCard(user['name'], user['avatarUrl'], user['distance'], user['comment'], user['howStrong']);
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

  Widget _userCard(String name, String imagePath, String distance, String text, int howStrong) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imagePath), // ここに適切な画像のURLやパスを設定
      ),
      title: Text(name),
      subtitle: Text('$text - $distance - Drinks: $howStrong'),
    );
  }
}
