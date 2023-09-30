import 'package:flutter/material.dart';

class SupabasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes Placeholder'),
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
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: 25,
                      itemBuilder: (BuildContext context, int index) {
                        return _userCard('User $index', 'assets/avatar.png', index + 1);
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

  Widget _userCard(String name, String imagePath, int drinks) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imagePath), // ダミーの画像パス
      ),
      title: Text(name),
      subtitle: Text('Drinks: $drinks'),
    );
  }
}
