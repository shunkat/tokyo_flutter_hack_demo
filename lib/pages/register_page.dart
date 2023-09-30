import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image/image.dart' as img;
import 'package:tokyo_flutter_hack_demo/common/styles/app_text_style.dart';
import 'package:tokyo_flutter_hack_demo/features/image_picker/image_picker_page2.dart';
import 'package:tokyo_flutter_hack_demo/models/user/user.dart';
import 'package:tokyo_flutter_hack_demo/utils/AppPreference.dart';
import 'package:tokyo_flutter_hack_demo/utils/determinPosition.dart';

class RegisterPage extends HookWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = useState<img.Image?>(null);
    final name = useState<String>("");
    final comment = useState<String>("");

    return Scaffold(
      appBar: AppBar(
        title: const Text('登録'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 100),
          Text('Welcome Page',
              style: AppTextStyle.noto16.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 100),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100),
              ),
              width: 100,
              height: 100,
              clipBehavior: Clip.hardEdge,
              child: image.value != null
                  ? Image.memory(
                      Uint8List.fromList(img.encodeJpg(image.value!)),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImagePicker2(
                            title: const Text("画像選択"),
                            onImageSelected: (value) {
                              image.value = value;
                              Navigator.pop(context);
                            },
                          )));
            },
          ),
          const Text('名前'),
          TextField(
            onChanged: (value) {
              name.value = value;
            },
          ),
          const Text('コメント'),
          TextField(
            onChanged: (value) {
              comment.value = value;
            },
          ),
          TextButton(
            onPressed: () async {
              final id =
                  FirebaseFirestore.instance.collection('users').doc().id;

              final imageRef =
                  FirebaseStorage.instance.ref().child('users/$id.jpg');
              // 1年の秒数
              await imageRef.putData(
                Uint8List.fromList(img.encodeJpg(image.value!)),
                SettableMetadata(
                  cacheControl: 'public, max-age=31536000, s-maxage=31536000',
                  contentType: 'image/jpeg',
                ),
              );

              final avatarUrl = await imageRef.getDownloadURL();

              final position = await determinePosition();
              final user = User(
                id: id,
                name: name.value,
                avatarUrl: avatarUrl,
                latitude: position.latitude,
                longitude: position.longitude,
                isActive: false,
                fcmToken: null,
                nearbyUserIds: [],
              );

              await FirebaseFirestore.instance.collection('users').doc(id).set(
                    user.toFirestoreJson(),
                  );

              await AppPreference().setUserId(id);

              Navigator.pop(context);
            },
            child: const Text('登録'),
          ),
        ],
      ),
    );
  }
}
