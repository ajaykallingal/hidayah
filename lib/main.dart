
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hidayah/src/constants/app_state.dart';
import 'package:hidayah/src/shared_pref/object_factory.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'my_app.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "high importance channel",
    "This channel is used for important notification"
"High important notification",
importance: Importance.high,
playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
//   await Firebase.initializeApp();
//   print("A bg message just showed up : ${message.messageId}");
// }

 void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await flutterLocalNotificationsPlugin
  // .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  // ?.createNotificationChannel(channel);
  //
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );

 

  final SharedPreferences sharedPreferences =
await SharedPreferences.getInstance();
  ObjectFactory().setPrefs(sharedPreferences);

/// setting pref

SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
statusBarColor:const Color(0xff0F0F0F).withOpacity(0.2),
statusBarBrightness: Brightness.light,
statusBarIconBrightness: Brightness.light,
));

///setting device orientationas portrait then calling runApp method
SystemChrome.setPreferredOrientations(<DeviceOrientation> [DeviceOrientation.portraitUp]).then((_) {
runApp(
ChangeNotifierProvider<AppState>(

  create: (BuildContext context) => AppState(),
child: const MyApp(),

),
);
});



}




