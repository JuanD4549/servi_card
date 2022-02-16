import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:servi_card/src/service/usuario_service.dart';
import 'package:servi_card/src/pages/home_page.dart';
import 'package:servi_card/src/pages/login_page.dart';
import 'package:servi_card/src/pages/setting_page.dart';
import 'package:servi_card/src/pages/sing_up_page.dart';
import 'package:servi_card/src/providers/main_provider.dart';
import 'package:servi_card/src/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:developer' as developer;

import 'firebase_options.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  developer.log('Handling a background message ${message.messageId}');
}
/*Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  developer.log('Handing a background message ${message.messageId}');
}*/
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 //Notificacion cuando la aplicacion esta cerrada
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
 if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MainProvider())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UsuarioService usuarioService = UsuarioService();
  @override
  void initState() {
    super.initState();
     FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? value) => developer.log(value.toString()));

  //Notificacion cuando la aplicación esta en Segundo Plano
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });

    //Notificacion cuando la aplicacion esta abierta
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      developer.log('A new onMessageOpenedApp event was published!');
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
    return FutureBuilder<bool>(
        future: mainProvider.getPreferences(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ScreenUtilInit(
                builder: () => MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: AppTheme.themeData(mainProvider.mode),
                    routes: {
                      "/login": (context) => const LoginPage(),
                      "/singUp": (context) => const SignUpPage(),
                      "/settings": (context) => const SettingPage(),
                      "/home": (context) => const HomePage(),
                    },
                    home: mainProvider.token == ""
                        ? const LoginPage()
                        : usuarioService.validToken(mainProvider.token)
                            ? const LoginPage()
                            : const HomePage()));
          }
          return const SizedBox.square(
              dimension: 100.0, child: CircularProgressIndicator());
        });
  }
}
