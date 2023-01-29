import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;

import 'package:tamuhack2023/logging.dart';
import 'package:tamuhack2023/models/api_response.dart';
import 'package:tamuhack2023/screens/camera.dart';
import 'package:tamuhack2023/utils.dart';

final backendUrl =
    Uri.parse("https://tamuhack2023-backend.elinicksic1.repl.co/analyze");

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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Stack(
          children: [
            // Display the camera
            OrientationBuilder(builder: (context, orientation) {
              return Padding(
                padding: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.longestSide -
                          _controller.value.previewSize!.longestSide) /
                      3,
                ),
                // padding: orientation == Orientation.portrait
                //     ? const EdgeInsets.only(top: 75)
                //     : const EdgeInsets.only(left: 75),
                child: FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If the Future is complete, display the preview.
                      return CameraPreview(_controller);
                    } else {
                      // Otherwise, display a loading indicator.
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              );
            }),

            OrientationBuilder(builder: (context, orientation) {
              return Align(
                alignment: orientation == Orientation.portrait
                    ? Alignment.bottomCenter
                    : Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    // Capture a photo and moves to the next screen
                    onTap: () async {
                      try {
                        // Ensure that the camera is initialized.
                        await _initializeControllerFuture;

                        // Attempt to take a picture and get the file `image`
                        // where it was saved.
                        final image = await _controller.takePicture();

                        final response = await http.post(
                          backendUrl,
                          body: base64Encode(await image.readAsBytes()),
                        );

                        final data =
                            ApiResponse.fromJson(jsonDecode(response.body));
                      } catch (e) {
                        // If an error occurs, log the error to the console.
                        print(e);
                      }
                    },

                    // Add feedback on tap
                    // TODO: tap animation
                    onTapDown: (details) {
                      print('down');
                    },
                    onTapUp: (details) {
                      print('up');
                    },

                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
