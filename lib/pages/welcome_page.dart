import 'package:flutter/material.dart';
import 'package:tokyo_flutter_hack_demo/common/styles/app_text_style.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Welcome Page',
            style: AppTextStyle.noto16.copyWith(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
