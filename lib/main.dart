import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_managment/db/db_functions.dart';
import 'package:student_managment/screens/ScreenHome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBFunctions.openDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Student Details",
      theme: ThemeData(primaryColor: Colors.black),
      home: ScreenHome(),
    );
  }
}
