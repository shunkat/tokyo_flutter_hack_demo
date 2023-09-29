import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tokyo_flutter_hack_demo/common/styles/app_text_style.dart';
import 'package:tokyo_flutter_hack_demo/router.dart';
import 'firebase_options.dart';
import 'supabase_page.dart';
import 'firebase_page.dart';

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

  runApp(const MyApp());
}

class MyApp extends HookWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        // splash screenの固定を解除してから画面遷移（諸々初期化後に解除する）
        FlutterNativeSplash.remove();
        goRouter.replace('/home');
      });
      return null;
    }, []);

    return MaterialApp.router(
      // goRouterの設定
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
      theme: ThemeData(
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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Select Page',
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              child: Text('Firebaseの画面へ'),
            ),
          ],
        ),
      ),
    );
  }
}
