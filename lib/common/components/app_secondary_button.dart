import 'package:flutter/material.dart';
import 'package:tokyo_flutter_hack_demo/common/styles/app_color.dart';
import 'package:tokyo_flutter_hack_demo/common/styles/app_text_style.dart';

class AppSecondaryButton extends StatelessWidget {
  const AppSecondaryButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.isDisabled = false,
    this.isLoading = false,
    this.style = AppButtonStyle.filled,
  }) : super(key: key);

  final VoidCallback onTap;
  final String text;
  final bool isDisabled;
  final bool isLoading;
  final AppButtonStyle style;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (isDisabled || isLoading) return;
          onTap.call();
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 24,
          decoration: BoxDecoration(
            color: style.backgroundColor(isDisabled || isLoading),
            borderRadius: BorderRadius.circular(70),
            border: style.border(isDisabled || isLoading),
            // boxShadow: style.boxShadow(isDisabled || isLoading),
          ),
          child: isLoading
              ? Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: style.indicatorColor,
                    ),
                  ),
                )
              : Text(
                  text,
                  style: AppTextStyle.noto12Medium.copyWith(
                    color: AppColor.white,
                  ),
                ),
        ));
  }
}

enum AppButtonStyle {
  filled,
  bordered;

  Color backgroundColor(bool isDisabled) {
    switch (this) {
      case AppButtonStyle.filled:
        return isDisabled
            ? AppColor.black600.withOpacity(0.6)
            : AppColor.secondary;
      case AppButtonStyle.bordered:
        return Colors.transparent;
    }
  }

  Color textColor(bool isDisabled) {
    switch (this) {
      case AppButtonStyle.filled:
        return AppColor.black;
      case AppButtonStyle.bordered:
        return isDisabled
            ? AppColor.black600.withOpacity(0.4)
            : AppColor.secondary;
    }
  }

  Color get indicatorColor {
    switch (this) {
      case AppButtonStyle.filled:
        return Colors.white;
      case AppButtonStyle.bordered:
        return AppColor.black600.withOpacity(0.4);
    }
  }

  Border? border(bool isDisabled) {
    switch (this) {
      case AppButtonStyle.filled:
        return null;
      case AppButtonStyle.bordered:
        return isDisabled
            ? Border.all(color: AppColor.black600.withOpacity(0.4))
            : Border.all(color: AppColor.black600);
    }
  }

  List<BoxShadow>? boxShadow(bool isDisabled) {
    switch (this) {
      case AppButtonStyle.filled:
        return [
          BoxShadow(
            color: AppColor.black600.withOpacity(0.3),
            offset: const Offset(0, 3),
            blurRadius: 6,
          )
        ];
      case AppButtonStyle.bordered:
        return null;
    }
  }
}
