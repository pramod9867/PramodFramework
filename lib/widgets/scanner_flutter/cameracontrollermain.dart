import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/scanner_flutter/takepicturescreen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dhanvarsha/constants/colors.dart';


class CammeraControllerMain extends StatefulWidget {
  final CameraDescription camera;
  const CammeraControllerMain({Key? key, required this.camera})
      : super(key: key);

  @override
  _CammeraControllerMainState createState() => _CammeraControllerMainState();
}

class _CammeraControllerMainState extends State<CammeraControllerMain> {
  String imagePath = "";



  @override
  void initState() {


    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TakePictureScreen(
                  camera: widget.camera,
                  imageSelect: (XFile) {
                    print("NEW XFILE IS");
                    print(XFile!.path);

                    setState(() {
                      imagePath = XFile.path;
                    });
                  },
                )),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                alignment: Alignment.center,
                color: AppColors.buttonRed,
                height: 100,
                width: SizeConfig.screenWidth - 30,
                child: Text("Move To Camera Controleer"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Image.file(
                File(imagePath),
                fit: BoxFit.fill,
                height: 100,
                width: 100,
              ),
            )
            // Image.file(file)
          ],
        ),
      ),
    );
  }
}
