import 'dart:io';

import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/imagepicker.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnImageUpload = Function();

class CustomImageBuilder extends StatefulWidget {
  final String value;
  final String image;
  final OnImageUpload? isimageupload;
  final String url;
  final bool isPan;
  final bool isAadhaarOrPan;

  const CustomImageBuilder(
      {Key? key,
      this.value = "",
      this.image = DhanvarshaImages.pan,
      this.isimageupload,
      this.url = '',
      this.isPan = false,
      this.isAadhaarOrPan = false})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => CustomImageBuilderState();
}

class CustomImageBuilderState extends State<CustomImageBuilder> {
  late ValueNotifier<String> imagepicked;

  String filename = '';
  String fileType = '';

  @override
  void initState() {
    // TODO: implement initState
    if (widget.url == '') {
      imagepicked = ValueNotifier("");
    } else {
      imagepicked = ValueNotifier(widget.url);
    }
    imagepicked.addListener(() {
      if (imagepicked.value != "") {
        widget!.isimageupload!();
      }
    });
    if (Uri.parse(widget.url).isAbsolute || widget.url != "") {
      String extension = widget.url.substring(widget.url.lastIndexOf("."));

      if (extension == '.pdf') {
        fileType = 'pdf';
      } else {
        fileType = "";
      }
    }

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    imagepicked.removeListener(() {
      if (imagepicked.value != "") {
        widget!.isimageupload!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: imagepicked,
        builder: (BuildContext context, String hasError, child) {
          if (imagepicked.value == '') {
            return Container(
              child: _getHoirzontalImageUpload(),
            );
          } else {
            return Container(child: _getFilemageUpload());
          }
          ;
        });
  }

  openImagePicker() {
    ImagePickerUtils.showDialogUtil(
        context,
        (imageFile) => {
              imagepicked.value = imageFile!.path,
              fileType = imageFile.mimeType != null ? imageFile.mimeType! : "",
              print("File Type 1"),
              print(fileType),
            },

        isPan: widget.isPan,
        isAadhaarPan: widget.isAadhaarOrPan);
  }

  Widget _getHoirzontalImageUpload() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              openImagePicker();
            },
            child: Container(
              width: SizeConfig.screenWidth * 0.35,
              height: SizeConfig.screenHeight * 0.15,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: AppColors.white),
              ),
              child: Image.asset(widget.image),
              margin: EdgeInsets.symmetric(vertical: 10),
            ),
          ),

          //_getTitleBusiness(),
          //_getTextAadhar(),
          //_TakePhotoAadharButton()
        ],
      ),
    );
  }

  Widget _getFilemageUpload() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (fileType == "") {
              } else {
                DialogUtils.showInfo(context, imagepicked.value);
              }
              // ImagePickerUtils.showDialogUtil(
              //     context,
              //     (imageFile) => {
              //           imagepicked.value = imageFile!.path,
              //           filename = imageFile.path.split('/').last,
              //           // print("File Type 2"),
              //           fileType = imageFile.mimeType != null
              //               ? imageFile.mimeType!
              //               : "",
              //           print("File Type 2"),
              //           print(fileType),
              //         },
              //     isPan: widget.isPan,
              //     isAadhaarPan: widget.isAadhaarOrPan);
            },
            child: Container(
              width: SizeConfig.screenWidth * 0.35,
              height: SizeConfig.screenHeight * 0.15,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: AppColors.white),
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  fileType == ''
                      ? Uri.parse(imagepicked.value).isAbsolute
                          ? Image.network(
                              imagepicked.value,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(imagepicked.value),
                              fit: BoxFit.cover,
                            )
                      : Center(
                          child: Image.asset(
                            DhanvarshaImages.tickmrk,
                            fit: BoxFit.cover,
                            height: 35,
                            width: 35,
                          ),
                        ),
                  // imagepicked.value == ''?
                  // Image.file(
                  //   File(imagepicked.value),
                  //   fit: BoxFit.cover,
                  // )
                  // :
                  // Image.network(
                  //   widget.url,
                  //   fit: BoxFit.cover,
                  // )
                  GestureDetector(
                    onTap: () {
                      ImagePickerUtils.showDialogUtil(
                          context,
                          (imageFile) => {
                                imagepicked.value = imageFile!.path,
                                filename = imageFile.path.split('/').last,
                                // print("File Type 2"),
                                fileType = imageFile.mimeType != null
                                    ? imageFile.mimeType!
                                    : "",
                                print("File Type 2"),
                                print(fileType),
                              },
                          isPan: widget.isPan,
                          isAadhaarPan: widget.isAadhaarOrPan);
                    },
                    child: Image.asset(
                      DhanvarshaImages.edit,
                      width: 25,
                      height: 25,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
