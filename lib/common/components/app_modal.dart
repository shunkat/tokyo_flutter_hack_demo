import 'package:flutter/material.dart';
import 'package:tokyo_flutter_hack_demo/common/components/app_button.dart';
import 'package:tokyo_flutter_hack_demo/common/styles/app_text_style.dart';

class AppModal extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final Function() onButtonTapped;
  final String? cancelButtonText;
  final Function()? cancelButtonTapped;

  const AppModal({
    Key? key,
    required this.title,
    required this.description,
    this.buttonText = "OK",
    this.cancelButtonText,
    required this.onButtonTapped,
    this.cancelButtonTapped,
  }) : super(key: key);

  static show(
    BuildContext context, {
    required String title,
    required String description,
    String buttonText = "OK",
    required Function() onButtonTapped,
    String? cancelButtonText,
    Function()? cancelButtonTapped,
    bool barrierDismissible = true,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AppModal(
        title: title,
        description: description,
        buttonText: buttonText,
        onButtonTapped: onButtonTapped,
        cancelButtonText: cancelButtonText,
        cancelButtonTapped: cancelButtonTapped,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title.isNotEmpty)
              Text(
                title,
                style:
                    AppTextStyle.noto16.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 16),
            if (description.isNotEmpty)
              Text(description,
                  style: AppTextStyle.noto14, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            AppButton(
              onTap: onButtonTapped,
              text: buttonText,
            ),
            if (cancelButtonText != null &&
                cancelButtonText!.isNotEmpty &&
                cancelButtonTapped != null) ...{
              const SizedBox(height: 16),
              AppButton(
                onTap: cancelButtonTapped!,
                text: cancelButtonText!,
                style: AppButtonStyle.bordered,
              ),
            }
          ],
        ),
      ),
    );
  }
}
