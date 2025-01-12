import 'dart:math';

import 'package:camera/camera.dart';
import 'package:chat_application/view/Screens/camera/camera_view_screen.dart';
import 'package:chat_application/view/Screens/camera/video_view_screen.dart';
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



















// import 'dart:ffi';

// import 'dart:math';

// import 'package:camera/camera.dart';
// import 'package:chat_application/view/Screens/camera/camera_view_screen.dart';
// import 'package:chat_application/view/Screens/camera/video_view_screen.dart';
// import 'package:flutter/material.dart';



//   List<CameraDescription> cameras=[];
// // ignore: must_be_immutable
// class CameraScreen extends StatefulWidget {
//   CameraScreen({super.key, this.onSendImage});

//   late Function? onSendImage;
//   @override
//   // ignore: library_private_types_in_public_api
//   _CameraScreenState createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   // To display the current output from the Camera,create a controler of  CameraController.
//   //_initializeControllerFuture is used to store the result of the asynchronous initialization process of the CameraController.
//   // By assigning _controller.initialize() to _initializeControllerFuture, you are storing the Future returned by the initialize() method in the _initializeControllerFuture variable.

//   Future<void>? cameraValue;
//   late CameraController _cameraController;
//   List<CameraDescription> cameras = [];
//   bool isRecorde = false;
//   bool flash = false;
//   bool iscamerafront = true;
//   double transform = 0;
//   String videopath = "";

//   @override
//   void initState() {
//     super.initState();
//     _getCameras();
//   }

//   Future<void> _getCameras() async {
//     cameras = await availableCameras();
//     if (cameras.isNotEmpty) {
//       _cameraController = CameraController(cameras[0], ResolutionPreset.high);
//       cameraValue = _cameraController.initialize();
//     }
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _cameraController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           FutureBuilder(
//               future: cameraValue,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   // If the Future is complete, display the preview.
//                   return SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height,
//                       child: CameraPreview(_cameraController));
//                 } else {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               }),
//           Positioned(
//             bottom: 0,
//             child: Container(
//               color: Colors.black,
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       IconButton(
//                           onPressed: () {
//                             setState(() {
//                               flash = !flash;
//                             });
//                             flash
//                                 ? _cameraController
//                                     .setFlashMode(FlashMode.torch)
//                                 : _cameraController.setFlashMode(FlashMode.off);
//                           },
//                           icon: Icon(
//                             flash ? Icons.flash_on : Icons.flash_off,
//                             color: Colors.white,
//                             size: 28,
//                           )),
//                       GestureDetector(
//                         onLongPress: () async {
//                           await _cameraController.startVideoRecording();
//                           setState(() {
//                             isRecorde = true;
//                           });
//                         },
//                         onLongPressUp: () async {
//                           XFile videopath =
//                               await _cameraController.stopVideoRecording();
//                           setState(() {
//                             isRecorde = false;
//                           });
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (builder) => VideoView(
//                                         path: videopath.path,
//                                       )));
//                           // Get.toNamed(AppRoute.);
//                           // ignore: use_build_context_synchronously
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (builder) => VideoView(
//                                         path: videopath.path,
//                                       )));
//                         },
//                         onTap: () {
//                           if (!isRecorde) takePhoto(context);
//                         },
//                         child: isRecorde
//                             ? const Icon(
//                                 Icons.radio_button_on,
//                                 color: Colors.red,
//                                 size: 70,
//                               )
//                             : const Icon(
//                                 Icons.panorama_fish_eye,
//                                 color: Colors.white,
//                                 size: 70,
//                               ),
//                       ),
//                       IconButton(
//                           icon: Transform.rotate(
//                             angle: transform,
//                             child: const Icon(
//                               Icons.flip_camera_ios,
//                               color: Colors.white,
//                               size: 28,
//                             ),
//                           ),
//                           onPressed: () async {
//                             setState(() {
//                               iscamerafront = !iscamerafront;
//                               transform = transform + pi;
//                             });
//                             int cameraPos = iscamerafront ? 0 : 1;
//                             _cameraController = CameraController(
//                                 cameras[cameraPos], ResolutionPreset.high);
//                             cameraValue = _cameraController.initialize();
//                           }),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     "Hold for video , tap for photo ",
//                     style: TextStyle(color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
  
// void takePhoto(BuildContext context) async {
//     XFile file = await _cameraController.takePicture();
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (builder) => CameraView(
//                   imagePath: file.path,
//                 )));
//   }
// }







// // ignore: must_be_immutable
// class CameraScreen extends StatefulWidget {
//   CameraScreen({super.key, this.onSendImage});

//   late Function? onSendImage;
//   @override
//   // ignore: library_private_types_in_public_api
//   _CameraScreenState createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   late CameraController _controller;
//    Future<void>? _initializeControllerFuture;
//   bool isRecorde = false;
//   String videopath = "";
//   List<CameraDescription> cameras=[];

//   // To display the current output from the Camera,create a controler of  CameraController.
//   //_initializeControllerFuture is used to store the result of the asynchronous initialization process of the CameraController.
//   // By assigning _controller.initialize() to _initializeControllerFuture, you are storing the Future returned by the initialize() method in the _initializeControllerFuture variable.

//   @override
//   void initState() {
//     super.initState();
//     _loadCameras();
//   }

//   Future<void> _loadCameras() async {
//     cameras = await availableCameras();
//     if (cameras.isNotEmpty) {
//       _controller = CameraController(
//         cameras[0],
//         ResolutionPreset.high,
//       );
//       _initializeControllerFuture = _controller.initialize();
//     } else {
//       print("No cameras available");
//     }
//   }

// // Dispose of the controller when the widget is disposed.
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           isRecorde?
//           FutureBuilder<void>(
//             future: _initializeControllerFuture,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 // If the Future is complete, display the preview.
//                 return CameraPreview(_controller);
//               } else {
//                 // Otherwise, display a loading indicator.
//                 return const Center(child: CircularProgressIndicator());
//               }
//             },
//           ): const Center(child: CircularProgressIndicator()),
//           Positioned(
//             bottom: 0,
//             child: Container(
//               // padding: const EdgeInsets.only(top: 5, bottom: 5),
//               color: Colors.black,
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                           onPressed: () {},
//                           icon: const Icon(
//                             Icons.flash_off,
//                             color: Colors.white,
//                             size: 28,
//                           )),
//                       GestureDetector(
//                         onLongPress: () async {
//                           await _controller.startVideoRecording();
//                           setState(() {
//                             isRecorde = true;
//                             videopath = 'path';
//                           });
//                         },
//                         onLongPressUp: () async {
//                           final videopath =
//                               await _controller.stopVideoRecording();
//                           setState(() {
//                             isRecorde = false;
//                           });
//                           // ignore: use_build_context_synchronously
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (builder) => VideoView(
//                                         path: videopath.path,
//                                       )));
//                         },
//                         onTap: () {
//                           if (!isRecorde) takephoto(context);
//                         },
//                         child: isRecorde
//                             ? const Icon(
//                                 Icons.radio_button_on,
//                                 color: Colors.red,
//                                 size: 70,
//                               )
//                             : const Icon(
//                                 Icons.panorama_fish_eye,
//                                 color: Colors.white,
//                                 size: 70,
//                               ),
//                       ),
//                       IconButton(
//                           onPressed: () {},
//                           icon: const Icon(
//                             Icons.flip_camera_ios,
//                             color: Colors.white,
//                             size: 28,
//                           )),
//                     ],
//                   ),
//                   const Text(
//                     "Hold for video , tap for photo ",
//                     style: TextStyle(color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> takephoto(BuildContext context) async {
//     try {
//       // Ensure that the camera is initialized.
//       await _initializeControllerFuture;

//       // Attempt to take a picture and get the file `image`
//       // where it was saved.
//       final image = await _controller.takePicture();

//       if (!context.mounted) return;

//       // If the picture was taken, display it on a new screen.
//       await Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => CameraView(
//             imagePath: image.path, onImageSend: widget.onSendImage,
//             // Pass the automatically generated path to
//             // the DisplayPictureScreen widget.
//           ),
//         ),
//       );
//     } catch (e) {
//       // If an error occurs, log the error to the console.
//       print(e);
//     }
//   }
// }




//   // void takephoto(BuildContext context) async {
//   //   final path =
//   //       join((await getTemporaryDirectory()).path, "${DateTime.now()}.png");
//   //   await _controller.takePicture();
//   //   // ignore: use_build_context_synchronously
//   //   Navigator.push(
//   //       context, MaterialPageRoute(builder: (builder) =>  CameraView(path: path,)));
//   // }
// // }

// // import 'dart:io';

// // // import 'package:camera/camera.dart';
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';

// // class CameraScreen extends StatefulWidget {
// //   const CameraScreen({super.key});

// //   @override

// //   State<CameraScreen> createState() => _CameraScreenState();
// // }

// // class _CameraScreenState extends State<CameraScreen> {
// //   File? myfile;
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: InkWell(
// //         onTap: () async {
// //           XFile? xfile =
// //               await ImagePicker().pickImage(source: ImageSource.camera);
// //           myfile = File(xfile!.path);
// //         },
// //       ),
// //     );
// //   }
// // }
