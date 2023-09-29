import 'package:flutter/material.dart';
import 'package:tokyo_flutter_hack_demo/common/styles/app_color.dart';

// color, weightはcopyWithで変更する
class AppTextStyle {
  static TextStyle get noto16 {
    return const TextStyle(
      fontFamily: 'NotoSansJP',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColor.black600,
    );
  }

  static TextStyle get noto14 {
    return const TextStyle(
      fontFamily: 'NotoSansJP',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColor.black600,
    );
  }
}
