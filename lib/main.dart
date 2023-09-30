import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tokyo_flutter_hack_demo/common/components/app_button.dart';
import 'package:tokyo_flutter_hack_demo/common/components/app_modal.dart';
import 'package:tokyo_flutter_hack_demo/common/styles/app_color.dart';
import 'package:tokyo_flutter_hack_demo/common/styles/app_text_style.dart';
import 'package:tokyo_flutter_hack_demo/features/image_picker/image_picker_page2.dart';
import 'package:tokyo_flutter_hack_demo/features/map/map_page.dart';
import 'package:tokyo_flutter_hack_demo/firebase_page.dart';
import 'package:tokyo_flutter_hack_demo/pages/register_page.dart';
import 'package:tokyo_flutter_hack_demo/pages/welcome_page.dart';
import 'package:tokyo_flutter_hack_demo/router.dart';
import 'package:tokyo_flutter_hack_demo/services/push_notification_service.dart';
import 'package:tokyo_flutter_hack_demo/supabase_page.dart';
import 'package:tokyo_flutter_hack_demo/utils/AppPreference.dart';

import 'firebase_options.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // splash screenをremoveされるまで固定表示
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: '.env');

  // supabaseの初期化
  await Supabase.initialize(
      url: dotenv.get('supabaseUrl'), anonKey: dotenv.get('supabaseAnonKey'));

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
        final userId = ref.read(userIdProvider);
        if (userId == null) {
          // userIdがない場合はwelcome画面へ
          goRouter.replace('/welcome');
          // goRouter.replace('/');
        } else {
          goRouter.replace('/');
          // goRouter.replace('/');
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

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Select Page',
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppButton(
                onTap: () {
                  AppModal.show(
                    context,
                    title: 'モーダル',
                    description: 'ディスクリプション',
                    cancelButtonText: 'キャンセル',
                    onButtonTapped: () {
                      Navigator.pop(context);
                    },
                    cancelButtonTapped: () {
                      Navigator.pop(context);
                    },
                  );
                },
                text: 'OK',
                style: AppButtonStyle.filled),
            const SizedBox(
              height: 8,
            ),
            AppButton(
                onTap: () {
                  print('tapped!');
                },
                text: 'キャンセル',
                style: AppButtonStyle.bordered),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SupabasePage()));
              },
              child: Text('Supabaseの画面へ',
                  style: AppTextStyle.noto14.copyWith(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FirebasePage()));
              },
              child: const Text('Firebaseの画面へ'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImagePicker2(
                              title: const Text("画像選択"),
                              onImageSelected: (image) {
                                Navigator.pop(context);
                              },
                            )));
              },
              child: const Text('Picker画面へ'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MapPage(),
                  ),
                );
              },
              child: const Text('Map画面へ'),
            ),
            if (ref.watch(userIdProvider) == null)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
                child: const Text('登録画面へ'),
              ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomePage(),
                  ),
                );
              },
              child: const Text('welcome画面へ'),
            )
          ],
        ),
      ),
    );
  }
}
