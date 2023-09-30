import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tokyo_flutter_hack_demo/common/components/app_button.dart';
import 'package:tokyo_flutter_hack_demo/common/styles/app_color.dart';
import 'package:tokyo_flutter_hack_demo/common/styles/app_text_style.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            AppColor.welcomGradientTop,
            AppColor.welcomGradientBottom,
          ],
          stops: [0.5, 1.0],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/welcomeLogo.png",
                  scale: 2,
                ),
                const SizedBox(
                  height: 16,
                  width: double.infinity,
                ),
                Image.asset(
                  "assets/images/welcome.png",
                  scale: 2,
                ),
                const SizedBox(height: 67),
                Text(
                  "自分の近くでスト缶を飲んでいる人を見つけて繋がりましょう！",
                  style: AppTextStyle.noto20Mediumn,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 260,
                  child: Text(
                    "きっと楽しくて新鮮な飲みの場になるはずです！",
                    style: AppTextStyle.noto18,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 70),
                AppButton(
                    onTap: () {
                      GoRouter.of(context).push('/register');
                    },
                    text: "はじめる")
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
