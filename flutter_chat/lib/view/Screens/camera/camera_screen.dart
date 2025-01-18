import 'dart:math';

import 'package:camera/camera.dart';
import 'package:chatapp/view/Screens/camera/camera_view_screen.dart';
import 'package:chatapp/view/Screens/camera/video_view_screen.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key, this.onSendImage});

  final Function? onSendImage;

  @override
  // ignore: library_private_types_in_public_api
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  Future<void>? cameraValue;
  late CameraController _cameraController;
  List<CameraDescription> cameras = [];
  bool isRecording = false;
  bool flash = false;
  bool isCameraFront = true;
  double transform = 0;

  @override
  void initState() {
    super.initState();
    _getCameras();
  }

  Future<void> _getCameras() async {
    cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      _cameraController = CameraController(cameras.first, ResolutionPreset.high);
      cameraValue = _cameraController.initialize();
    }
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_cameraController);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          _buildControlPanel(context),
        ],
      ),
    );
  }

  Widget _buildControlPanel(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFlashButton(),
                _buildCaptureButton(context),
                _buildSwitchCameraButton(),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "Hold for video, tap for photo",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  IconButton _buildFlashButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          flash = !flash;
        });
        flash
            ? _cameraController.setFlashMode(FlashMode.torch)
            : _cameraController.setFlashMode(FlashMode.off);
      },
      icon: Icon(flash ? Icons.flash_on : Icons.flash_off, color: Colors.white, size: 28),
    );
  }

  GestureDetector _buildCaptureButton(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        await _cameraController.startVideoRecording();
        setState(() {
          isRecording = true;
        });
      },
      onLongPressUp: () async {
        final videoPath = await _cameraController.stopVideoRecording();
        setState(() {
          isRecording = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (builder) => VideoView(path: videoPath.path)),
        );
      },
      onTap: () {
        if (!isRecording) takePhoto(context);
      },
      child: isRecording
          ? const Icon(Icons.radio_button_on, color: Colors.red, size: 70)
          : const Icon(Icons.panorama_fish_eye, color: Colors.white, size: 70),
    );
  }

  IconButton _buildSwitchCameraButton() {
    return IconButton(
      icon: Transform.rotate(
        angle: transform,
        child: const Icon(Icons.flip_camera_ios, color: Colors.white, size: 28),
      ),
      onPressed: () {
        setState(() {
          isCameraFront = !isCameraFront;
          transform += pi;
        });
        int cameraPos = isCameraFront ? 0 : 1;
        _cameraController = CameraController(cameras[cameraPos], ResolutionPreset.high);
        cameraValue = _cameraController.initialize();
      },
    );
  }

  Future<void> takePhoto(BuildContext context) async {
    final file = await _cameraController.takePicture();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => CameraView(imagePath: file.path),
      ),
    );
  }
}
