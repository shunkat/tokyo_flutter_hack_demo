import 'package:flutter/material.dart';
import 'package:tokyo_flutter_hack_demo/common/styles/app_color.dart';

// color, weightはcopyWithで変更する
class AppTextStyle {
  static TextStyle get noto56Mediumn {
    return const TextStyle(
      fontFamily: 'NotoSansJP',
      fontSize: 56,
      fontWeight: FontWeight.w600,
      color: AppColor.black600,
    );
  }

  static TextStyle get noto24Mediumn {
    return const TextStyle(
      fontFamily: 'NotoSansJP',
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: AppColor.black600,
    );
  }

  static TextStyle get noto20Mediumn {
    return const TextStyle(
      fontFamily: 'NotoSansJP',
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: AppColor.black600,
    );
  }

  static TextStyle get noto18 {
    return const TextStyle(
      fontFamily: 'NotoSansJP',
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColor.black600,
    );
  }

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

  static TextStyle get noto12medium {
    return const TextStyle(
      fontFamily: 'NotoSansJP',
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColor.black600,
    );
  }

  static TextStyle get noto14Medium {
    return const TextStyle(
      fontFamily: 'NotoSansJP',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColor.black600,
    );
  }

  static TextStyle get noto12Medium {
    return const TextStyle(
      fontFamily: 'NotoSansJP',
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColor.black600,
    );
  }

  static TextStyle get hint {
    return const TextStyle(
      fontFamily: 'NotoSansJP',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColor.hintText,
    );
  }
}
