import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  static Future<String?> getToken() async {
    final messaging = FirebaseMessaging.instance;
    return messaging.getToken();
  }

  static Future<NotificationSettings> requestPermission() async {
    final messaging = FirebaseMessaging.instance;
    return messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  // アプリがバックグラウンド状態から開いた状態になった場合の処理
  static startListeningOnPushMessageOpenedApp() {
    print('start listening on push message opened app.');
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      // なぜかAndroidだとバックグラウンドからの復帰時にinitialMessageが複数個溜まっていることがあるので、無駄にプッシュ通知をハンドリングしないよう全消費しておく
      // 解決していないissue）https://github.com/firebase/flutterfire/issues/4188
      RemoteMessage? initialMessage = await getInitialPushMessage();
      while (initialMessage != null) {
        initialMessage = await getInitialPushMessage();
      }
      handlePushMessage(message);
    });
  }

  // アプリが起動していない状態で、通知をタップして起動した時に呼ばれる
  static Future<RemoteMessage?> getInitialPushMessage() async {
    return FirebaseMessaging.instance.getInitialMessage();
  }

  static Future<void> handleInitialPushMessage() async {
    final message = await getInitialPushMessage();
    if (message != null) {
      handlePushMessage(message);
    }
  }

  //--------------------
  // androidの通知チャンネル作成
  //--------------------
  static Future<void> initializeLocalNotifications() async {
    FlutterLocalNotificationsPlugin notificationPlugin =
        FlutterLocalNotificationsPlugin();
    // TODO: アイコン変更
    const initializationSettings = InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings(
            '@drawable/ic_stat_oshigoto_splash_icon'));
    await notificationPlugin.initialize(
      initializationSettings,
    );
  }

  static Future<void> createNotificationChannel(String id, String name) async {
    final notificationPlugin = FlutterLocalNotificationsPlugin();
    final channel = AndroidNotificationChannel(id, name,
        // これでポップアップ通知がデフォルトで許可になる
        importance: Importance.high);
    await notificationPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  //--------------------
  // 通知の処理
  //--------------------
  static Future<void> handlePushMessage(RemoteMessage message) async {
    print('handlePushMessage: $message');
  }
}

enum NotificationDataKey {
  url,
}
