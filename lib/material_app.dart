import 'dart:io';
import 'package:absurd_toolbox/screens/barcode_scanner_screen.dart';
import 'package:absurd_toolbox/screens/sound_recorder_screen.dart';
import 'package:absurd_toolbox/widgets/stateful_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:absurd_toolbox/providers/notes.dart';
import 'package:absurd_toolbox/screens/raffles_screen.dart';
import 'package:absurd_toolbox/screens/note_screen.dart';
import 'package:absurd_toolbox/screens/home_screen.dart';
import 'package:absurd_toolbox/screens/notes_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const periodicTask = "PERIODIC_TASK";

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _showNotificationWithNoSound(int totalExecutions) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'silent channel id',
    'silent channel name',
    channelDescription: 'silent channel description',
    playSound: false,
    styleInformation: DefaultStyleInformation(true, true),
  );
  const IOSNotificationDetails iOSPlatformChannelSpecifics =
      IOSNotificationDetails(
    threadIdentifier: 'thread_id',
  );

  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin.show(
    0,
    '<b>totalExecutions:</b> $totalExecutions,',
    '<b>silent</b> body',
    platformChannelSpecifics,
  );
}

/// Proceso en segundo plano.
/// Carga un int almacenado en shared-preferences (=1 si no existe), lo muestra
/// en una notificación  y le suma 1.
/// Si el int > 2 se cancela el proceso.
void backgroundDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Ejecutada tarea: $task");

    switch (task) {
      case periodicTask:
        {
          print("MATCH CASE " + periodicTask);

          int? totalExecutions;
          final _sharedPreference = await SharedPreferences.getInstance();

          try {
            totalExecutions = _sharedPreference.getInt("totalExecutions");

            if (totalExecutions == null) {
              totalExecutions = 1;
            } else {
              totalExecutions += 1;
            }

            _showNotificationWithNoSound(totalExecutions);

            if (totalExecutions > 2) Workmanager().cancelByUniqueName("1");

            _sharedPreference.setInt("totalExecutions", totalExecutions);
          } catch (err) {
            print(err.toString());

            throw Exception(err);
          }

          break;
        }
      default:
        {
          print("NO MATCH?");
          print("task: " + task);
        }
    }

    return Future.value(true);
  });
}

class MyMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<Notes>(context, listen: false).reloadNotesFromStorage();

    void onDidReceiveLocalNotification(
      int id,
      String? title,
      String? body,
      String? payload,
    ) async {
      // display a dialog with the notification details, tap ok to go to another page
      showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title ?? ''),
          content: Text(body ?? ''),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }

    return StatefulWrapper(
      onInit: () async {
        const AndroidInitializationSettings initializationSettingsAndroid =
            AndroidInitializationSettings('ic_notification');
        final IOSInitializationSettings initializationSettingsIOS =
            IOSInitializationSettings(
                onDidReceiveLocalNotification: onDidReceiveLocalNotification);
        final InitializationSettings initializationSettings =
            InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

        await flutterLocalNotificationsPlugin.initialize(initializationSettings,
            onSelectNotification: (String? payload) async {
          if (payload != null) {
            debugPrint('notification payload: $payload');
          }
        });

        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            );

        if (Platform.isAndroid) {
          Workmanager()
              .initialize(backgroundDispatcher, isInDebugMode: true)
              .then((value) {
            Workmanager().registerPeriodicTask(
              "1",
              periodicTask,
              frequency: Duration(minutes: 15),
            );
          });
        } else if (Platform.isIOS) {}
      },
      child: MaterialApp(
        initialRoute: '/',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => HomeScreen(),
          NotesScreen.routeName: (context) => NotesScreen(),
          NoteScreen.routeName: (context) => NoteScreen(),
          RafflesScreen.routeName: (context) => RafflesScreen(),
          BarcodeScannerScreen.routeName: (context) => BarcodeScannerScreen(),
          SoundRecorderScreen.routeName: (context) => SoundRecorderScreen(),
        },
      ),
    );
  }
}
