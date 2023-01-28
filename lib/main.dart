import 'dart:async';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:tamuhack2023/logging.dart';
import 'package:tamuhack2023/camera.dart';
import 'package:tamuhack2023/utils.dart';

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
      home: const App(),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final CameraDescription camera = _cameras.first;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int buttonAlpha = 128;

    return Scaffold(
      body: Stack(
        children: [
          // Display the camera
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                return FullscreenWidget(controller: _controller);
              } else {
                // Otherwise, display a loading indicator.
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),

          OrientationBuilder(builder: (context, orientation) {
            return Align(
              alignment: orientation == Orientation.portrait
                  ? Alignment.bottomCenter
                  : Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  // Capture a photo and moves to the next screen
                  onTap: () {
                    print('test');
                  },

                  // Add feedback on tap
                  onTapDown: (details) {
                    setState(() {
                      buttonAlpha = 255;
                    });
                    print('down $buttonAlpha');
                  },
                  onTapUp: (details) {
                    setState(() {
                      buttonAlpha = 128;
                    });
                    print('up $buttonAlpha');
                  },

                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(buttonAlpha, 0, 0, 0),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 5),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
