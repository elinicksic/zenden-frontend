import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FullscreenWidget extends StatelessWidget {
  final CameraController controller;

  const FullscreenWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return Transform.scale(
      scale: controller.value.aspectRatio / deviceRatio,
      child: Center(
        child: CameraPreview(controller),
      ),
    );
  }
}
