import 'dart:async';
import 'package:algad_infohub/Authintication/LoginWithGoogle/login.dart';
import 'package:algad_infohub/Authintication/LoginWithGoogle/loginWithGoogle.dart';
import 'package:algad_infohub/Authintication/cubit/cubit.dart';
import 'package:algad_infohub/Authintication/login/login_screen.dart';
import 'package:algad_infohub/Authintication/login/login_screen_two.dart';
import 'package:algad_infohub/Authintication/register/register_screen.dart';
import 'package:algad_infohub/blocObserver.dart';
import 'package:algad_infohub/layout/admin/admin_layout.dart';
import 'package:algad_infohub/modules/Admin/addresses_add_screen.dart';
import 'package:algad_infohub/modules/Admin/control_screen.dart';
import 'package:algad_infohub/modules/Admin/jobs_add_screen.dart';
import 'package:algad_infohub/modules/Admin/news_add_screen.dart';
import 'package:algad_infohub/modules/Admin/questions_add_screen.dart';
import 'package:algad_infohub/modules/Admin/users_screen.dart';
import 'package:algad_infohub/modules/addresses_screen/addresses_screen_two.dart';
import 'package:algad_infohub/modules/addresses_screen/admin_addresses_screen.dart';
import 'package:algad_infohub/modules/home_screen/home_screen.dart';
import 'package:algad_infohub/modules/jobs_screen/admins-jobs-screen.dart';
import 'package:algad_infohub/modules/jobs_screen/jobs_screen.dart';
import 'package:algad_infohub/modules/jobs_screen/jobs_screen_two.dart';
import 'package:algad_infohub/modules/news_screen/admin_news_screen.dart';
import 'package:algad_infohub/modules/news_screen/news_screen.dart';
import 'package:algad_infohub/modules/news_screen/news_screen_two.dart';
import 'package:algad_infohub/modules/questions_screen/admins_questions_screen.dart';
import 'package:algad_infohub/modules/questions_screen/questions_screen.dart';
import 'package:algad_infohub/modules/questions_screen/questions_screen_2.dart';
import 'package:algad_infohub/modules/search.dart';
import 'package:algad_infohub/modules/splash_screen/splash_screen.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//
// /// Streams are created so that app can respond to notification-related events
// /// since the plugin is initialised in the `main` function
// final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
//     StreamController<ReceivedNotification>.broadcast();
//
// final StreamController<String?> selectNotificationStream =
//     StreamController<String?>.broadcast();
//
// const MethodChannel platform =
//     MethodChannel('dexterx.dev/flutter_local_notifications_example');
//
// const String portName = 'notification_send_port';
//
// class ReceivedNotification {
//   ReceivedNotification({
//     required this.id,
//     required this.title,
//     required this.body,
//     required this.payload,
//   });
//
//   final int id;
//   final String? title;
//   final String? body;
//   final String? payload;
// }
//
// String? selectedNotificationPayload;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();


  // initLocalNotification();
  //
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Got a message whilst in the foreground!');
  //   print('Message data: ${message.data}');
  //
  //   if (message.notification != null) {
  //     print(
  //         'Message also contained a notification: ${message.notification!.title}');
  //     showNotification(
  //       message.notification!.title!,
  //       message.notification!.body!,
  //     );
  //   }
  // });
  //
  // FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
  //   showNotification(
  //     message.notification!.title!,
  //     message.notification!.body!,
  //   );
  // });
  runApp(const MyApp());
}

// void initLocalNotification() async {
//   // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
//   final DarwinInitializationSettings initializationSettingsDarwin =
//       const DarwinInitializationSettings();
//   final LinuxInitializationSettings initializationSettingsLinux =
//       const LinuxInitializationSettings(defaultActionName: 'Open notification');
//   final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsDarwin,
//       linux: initializationSettingsLinux);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       onDidReceiveNotificationResponse: (payload) async {
//     if (payload != null) {
//       debugPrint("notification payload: $payload");
//     }
//     selectedNotificationPayload = payload as String?;
//     selectNotificationStream.add(payload as String?);
//   });
// }
//
// Future<void> showNotification(String title, String body,) async {
//   const AndroidNotificationDetails androidNotificationDetails =
//       AndroidNotificationDetails(
//     'defaultNotification',
//     'Default Notifications',
//     channelDescription: 'your channel description',
//     importance: Importance.max,
//     priority: Priority.high,
//     ticker: 'ticker',
//   );
//   const NotificationDetails notificationDetails = NotificationDetails(
//     android: androidNotificationDetails,
//   );
//   await flutterLocalNotificationsPlugin.show(
//     0,
//     title,
//     body,
//     notificationDetails,
//     payload: 'item x',
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => InfoHubCubit(),
          ),
          BlocProvider(
            create: (context) => AuthCubit(),
          ),
        ],
        child: FirebaseAuth.instance.currentUser == null ? LoginScreen() : HomeScreen(),
      ),
      builder: EasyLoading.init(),
    );
  }
}

// FirebaseAuth.instance.currentUser == null ? LoginScreen() : HomeScreen()
