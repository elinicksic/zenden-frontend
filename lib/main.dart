import 'dart:async';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:tamuhack2023/logging.dart';
import 'package:tamuhack2023/screens/home.dart';

List<CameraDescription> _cameras = <CameraDescription>[];

Future<void> main() async {
  // Fetch the available cameras before initializing the app.
  try {
    WidgetsFlutterBinding.ensureInitialized();
    _cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: const Home(),
    );
  }
}