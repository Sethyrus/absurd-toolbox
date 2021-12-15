import 'package:absurd_toolbox/screens/barcode_scanner_screen.dart';
import 'package:absurd_toolbox/screens/sound_recorder_screen.dart';
import 'package:absurd_toolbox/widgets/stateful_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:absurd_toolbox/providers/notes.dart';
import 'package:absurd_toolbox/screens/raffles_screen.dart';
import 'package:absurd_toolbox/screens/note_screen.dart';
import 'package:absurd_toolbox/screens/home_screen.dart';
import 'package:absurd_toolbox/screens/notes_screen.dart';
import 'package:workmanager/workmanager.dart';
import 'package:intl/intl.dart';

const test1 = "test1";
const periodicTask = "periodicTask";

void backgroundDispatcher() {
  print("Background START!!");

  Workmanager().executeTask((task, inputData) {
    print("Ejecutada tarea: $task");

    switch (task) {
      case periodicTask:
        {
          print("MATCH CASE " + periodicTask);
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

  print("Background END!!");
}

class MyMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<Notes>(context, listen: false).reloadNotesFromStorage();

    return StatefulWrapper(
      onInit: () {
        Workmanager()
            .initialize(backgroundDispatcher, isInDebugMode: true)
            .then((value) {
          Workmanager().registerPeriodicTask(
            "2",
            periodicTask,
            inputData: <String, dynamic>{
              'string': new DateFormat('yyyy-MM-dd hh:mm').format(
                DateTime.now(),
              ),
            },
            // When no frequency is provided the default 15 minutes is set.
            // Minimum frequency is 15 min. Android will automatically change your frequency to 15 min if you have configured a lower frequency.
            frequency: Duration(minutes: 15),
            initialDelay: Duration(seconds: 30),
          );

          // Workmanager().registerOneOffTask(
          //   "1",
          //   "simpleTask",
          // ); //Android only (see below)

          // Workmanager().cancelAll();

          // Workmanager()
          //     .registerOneOffTask(
          //   "1",
          //   test1,
          //   inputData: <String, dynamic>{
          //     'int': 1,
          //     'bool': true,
          //     'double': 1.0,
          //     'string': 'string',
          //     'array': [1, 2, 3],
          //   },
          //   initialDelay: Duration(seconds: 20),
          // )
          //     .then((value) {
          //   print("STARTED TASK " + test1);
          // }).catchError((error, stackTrace) {
          //   print("START TASK ERROR FOR TASK " + test1);
          //   print(error);
          // });
        });
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
