import 'dart:ui';

import 'package:flutter/services.dart';

Future<Uint8List> uint8ListFromAsset(String path, int width) async {
  final ByteData byteData = await rootBundle.load(path);
  final Codec codec = await instantiateImageCodec(
    byteData.buffer.asUint8List(),
    targetWidth: width,
  );
  final FrameInfo uiFI = await codec.getNextFrame();
  return (await uiFI.image.toByteData(format: ImageByteFormat.png))!
      .buffer
      .asUint8List();
}
