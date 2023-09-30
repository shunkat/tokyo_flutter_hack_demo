import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:tokyo_flutter_hack_demo/common/styles/app_text_style.dart';
import 'package:tokyo_flutter_hack_demo/features/image_picker/image_picker_page2.dart';
import 'package:tokyo_flutter_hack_demo/models/user/user.dart';
import 'package:tokyo_flutter_hack_demo/utils/AppPreference.dart';
import 'package:tokyo_flutter_hack_demo/utils/determinPosition.dart';

final selectedImageProvider = StateProvider<img.Image?>((ref) {
  return null;
});

final nameProvider = StateProvider<String>((ref) {
  return "";
});

final commentProvider = StateProvider<String>((ref) {
  return "";
});

class RegisterPage extends HookConsumerWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = ref.watch(nameProvider.notifier);
    final commentController = ref.watch(commentProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('登録'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Text('Welcome Page',
                style:
                    AppTextStyle.noto16.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 100),
            Consumer(builder: (context, ref, _) {
              final image = ref.watch(selectedImageProvider);
              final imageController = ref.watch(selectedImageProvider.notifier);
              return GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  width: 100,
                  height: 100,
                  clipBehavior: Clip.hardEdge,
                  child: image != null
                      ? Image.memory(
                          Uint8List.fromList(img.encodeJpg(image)),
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
                                  imageController.state = value;
                                  Navigator.pop(context);
                                },
                              )));
                },
              );
            }),
            const Text('名前'),
            TextField(
              onChanged: (value) {
                nameController.state = value;
              },
            ),
            const Text('コメント'),
            TextField(
              onChanged: (value) {
                commentController.state = value;
              },
            ),
            TextButton(
              onPressed: () async {
                final id =
                    FirebaseFirestore.instance.collection('users').doc().id;

                final imageRef =
                    FirebaseStorage.instance.ref().child('users/$id.jpg');

                final image = ref.read(selectedImageProvider);
                await imageRef.putData(
                  Uint8List.fromList(img.encodeJpg(image!)),
                  SettableMetadata(
                    cacheControl: 'public, max-age=31536000, s-maxage=31536000',
                    contentType: 'image/jpeg',
                  ),
                );

                final avatarUrl = await imageRef.getDownloadURL();

                final position = await determinePosition();
                final user = User(
                  id: id,
                  name: ref.read(nameProvider),
                  comment: ref.read(commentProvider),
                  avatarUrl: avatarUrl,
                  latitude: position.latitude,
                  longitude: position.longitude,
                  isActive: false,
                  fcmToken: null,
                  howStrong: 0,
                  nearbyUserDetails: [],
                );

                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(id)
                    .set(
                      user.toFirestoreJson(),
                    );

                await AppPreference().setUserId(id);

                GoRouter.of(context).replace('/home');
              },
              child: const Text('登録'),
            ),
          ],
        ),
      ),
    );
  }
}
