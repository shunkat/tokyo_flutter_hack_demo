import 'package:flutter/material.dart';
import 'package:tokyo_flutter_hack_demo/features/image_picker/image_picker_page.dart';

class ImagePicker extends StatelessWidget {
  const ImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ImagePickerPage(title: Text("test")),
    );
  }
}
