import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:tokyo_flutter_hack_demo/common/components/app_button.dart';
import 'package:tokyo_flutter_hack_demo/common/styles/app_color.dart';
import 'package:tokyo_flutter_hack_demo/common/styles/app_text_style.dart';
import 'package:tokyo_flutter_hack_demo/features/image_picker/image_picker_page2.dart';
import 'package:tokyo_flutter_hack_demo/models/user/user.dart';
import 'package:tokyo_flutter_hack_demo/router.dart';
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
    final imageWidth = MediaQuery.of(context).size.width - 28;
    final nameController = ref.watch(nameProvider.notifier);
    final commentController = ref.watch(commentProvider.notifier);

    final isSending = useState<bool>(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('登録'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                width: 240,
                clipBehavior: Clip.hardEdge,
                child: TextField(
                  onChanged: (value) {
                    nameController.state = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "ニックネームを入力",
                    hintStyle: AppTextStyle.hint,
                    contentPadding: const EdgeInsets.all(20),
                    border: InputBorder.none,
                    fillColor: AppColor.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Consumer(builder: (context, ref, _) {
                final image = ref.watch(selectedImageProvider);
                final imageController =
                    ref.watch(selectedImageProvider.notifier);
                return GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    width: imageWidth,
                    height: imageWidth,
                    clipBehavior: Clip.hardEdge,
                    child: image != null
                        ? Image.memory(
                            Uint8List.fromList(img.encodeJpg(image)),
                            width: imageWidth,
                            height: imageWidth,
                            fit: BoxFit.cover,
                          )
                        : Image.asset("assets/images/thumbnail_placeholder.png",
                            fit: BoxFit.cover),
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
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                ),
                clipBehavior: Clip.hardEdge,
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  onChanged: (value) {
                    commentController.state = value;
                  },
                  decoration: InputDecoration(
                    hintText: "プロフィールに表示されるメッセージを記入する",
                    contentPadding: const EdgeInsets.all(20),
                    hintStyle: AppTextStyle.hint,
                    border: InputBorder.none,
                    fillColor: AppColor.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              AppButton(
                onTap: () async {
                  final id =
                      FirebaseFirestore.instance.collection('users').doc().id;

                  final imageRef =
                      FirebaseStorage.instance.ref().child('users/$id.jpg');

                  final image = ref.read(selectedImageProvider);
                  await imageRef.putData(
                    Uint8List.fromList(img.encodeJpg(image!)),
                    SettableMetadata(
                      cacheControl:
                          'public, max-age=31536000, s-maxage=31536000',
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

                  goRouter.push('/map');
                },
                text: "登録する",
                isLoading: isSending.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
