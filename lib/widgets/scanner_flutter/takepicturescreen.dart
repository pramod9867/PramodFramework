import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/utils/image_processor.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef onImageSelect = Function(File? xFile);

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  final onImageSelect? imageSelect;

  const TakePictureScreen({
    Key? key,
    required this.camera,
    this.imageSelect,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen>
    with WidgetsBindingObserver {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  Orientation? _currentOrientation;
  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    // _controller.
    WidgetsBinding.instance?.addObserver(this);
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.high,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void didChangeMetrics() {
    _currentOrientation = MediaQuery.of(context).orientation;
    print('Before Orientation Change: $_currentOrientation');
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      setState(() {
        _currentOrientation = MediaQuery.of(context).orientation;
      });
      print('After Orientation Change: $_currentOrientation');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  void onCaptureOrientationLockButtonPressed() async {
    try {
      if (_controller != null) {
        final CameraController cameraController = _controller!;
        if (cameraController.value.isCaptureOrientationLocked) {
          await cameraController.unlockCaptureOrientation();
          print("Capture unLocked");
        } else {
          await cameraController.lockCaptureOrientation();
          print("Capture Locked");
        }
      }
    } on CameraException catch (e) {
      // _showCameraException(e);
    }
  }

  takePictureFromCamera() async {
    XFile image = await _controller.takePicture();

    File imageNew =
        await ImageProcessor.cropSquare(image.path, image.path, false);

    widget.imageSelect!(imageNew);
    Navigator.pop(context);
    print(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight,
                        child: CameraPreview(
                          _controller,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(),
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2,
                                          color: AppColors.buttonRed)),
                                  height: 200,
                                  width: SizeConfig.screenWidth - 50,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.buttonRed,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "CANCEL",
                                            style: CustomTextStyles
                                                .regularWhiteMediumFont,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        takePictureFromCamera();
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.buttonRed,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "CAPTURE",
                                            style: CustomTextStyles
                                                .regularWhiteMediumFont,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      // Otherwise, display a loading indicator.
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                )
              : FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        height: SizeConfig.screenHeight,
                        child: CameraPreview(
                          _controller,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2,
                                          color: AppColors.buttonRed)),
                                  height: 200,
                                  width: SizeConfig.screenHeight - 50,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        takePictureFromCamera();
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.buttonRed,
                                        ),
                                        child: Center(
                                          child: Text("CAPTURE"),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        takePictureFromCamera();
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.buttonRed,
                                        ),
                                        child: Center(
                                          child: Text("CANCEL"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      // Otherwise, display a loading indicator.
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                );
        },
      ),
    );
  }
}
