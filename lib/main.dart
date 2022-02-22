import 'package:absurd_toolbox/src/helpers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:absurd_toolbox/src/material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'src/firebase_options.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.max,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void loaderConfig() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.black
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.black
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = true;
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Handling a background message: ${message.messageId}");

  if (message.notification != null) {
    log(
      'Message also contained a notification; Title: ${message.notification!.title}',
    );
  }

  log('Message data', message.data);
}

Future<void> _firebaseMessagingDefaultHandler(RemoteMessage message) async {
  log(
    'Got a message whilst in the foreground!',
    'Message data: ${message.data}',
  );

  if (message.notification != null) {
    log('Message also contained a notification: ${message.notification}');
  }

  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  // If `onMessage` is triggered with a notification, construct our own
  // local notification to show to users using the created channel.
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: android.smallIcon,
          // other properties...
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Se inicializa Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Setup notifications channel
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // Setup background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Setup local notifications instance
  const AndroidInitializationSettings initSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');
  const InitializationSettings initSettings = InitializationSettings(
    android: initSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
    onSelectNotification: (_) {},
  );

  // Setup foreground notifications configuration
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  // Setup foreground notifications
  FirebaseMessaging.onMessage.listen((event) {
    log("FirebaseMessaging.onMessage");
    _firebaseMessagingDefaultHandler(event);
  });

  // Se selecciona español como idioma por defecto de la aplicación
  Intl.defaultLocale = 'es_ES';
  // Se inicializan los textos para el formateo de fechas
  initializeDateFormatting('es_ES');

  // Se inicializa la configuración del loader
  loaderConfig();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Dummy focusNode al que hacer foco para quitarlo de otros
  final FocusNode _focusNode = FocusNode();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Elimina el foco de cualquier input al pulsar sobre un espacio libre
      onTap: () => FocusScope.of(context).requestFocus(_focusNode),
      child: const MyMaterialApp(),
    );
  }
}
