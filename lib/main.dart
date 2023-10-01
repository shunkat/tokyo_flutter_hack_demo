import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokyo_flutter_hack_demo/common/styles/app_color.dart';
import 'package:tokyo_flutter_hack_demo/router.dart';
import 'package:tokyo_flutter_hack_demo/services/push_notification_service.dart';
import 'package:tokyo_flutter_hack_demo/utils/AppPreference.dart';

import 'firebase_options.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // splash screenをremoveされるまで固定表示
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: '.env');

  // firebaseの初期化
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Androidの通知チャンネルを設定
  await PushNotificationService.initializeLocalNotifications();
  await PushNotificationService.createNotificationChannel(
      'tenisutokan_default_channel_id', 'tenisutokan_default_channel_name');

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        // push通知の設定
        await PushNotificationService.requestPermission();
        PushNotificationService.startListeningOnPushMessageOpenedApp();
        // アプリが起動していない状態で、通知をタップして起動した場合の通知処理
        await PushNotificationService.handleInitialPushMessage();

        // splash screenの固定を解除してから画面遷移（諸々初期化後に解除する）
        FlutterNativeSplash.remove();
        final userId = await AppPreference.getUserId();
        if (userId == null) {
          // userIdがない場合はwelcome画面へ
          goRouter.replace('/welcome');
        } else {
          goRouter.replace('/map');
        }
      });
      return null;
    }, []);

    return MaterialApp.router(
      // goRouterの設定
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.black,
          secondary: Colors.black,
          background: AppColor.background,
        ),
        // ripple effectの無効化
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        useMaterial3: true,
        // global fontの設定
        fontFamily: 'NotoSansJP',
      ),
    );
  }
}

class EmptyHomePage extends StatelessWidget {
  const EmptyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
    );
  }
}
