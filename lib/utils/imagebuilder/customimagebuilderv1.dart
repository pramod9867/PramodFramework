import 'dart:io';

import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/imagepicker.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomImageBuilderV1 extends StatefulWidget {
  final String value;
  final String type;
  final String image;
  final bool isPan;
  final String description;
  final VoidCallback? secondImageUpload;
  final String initialImage;
  final bool isAadhaarORPan;
  const CustomImageBuilderV1(
      {Key? key,
      this.value = "Front View",
      this.image = DhanvarshaImages.poa,
      this.type = "image",
      this.description = "",
      this.secondImageUpload,
      this.initialImage = "",
      this.isAadhaarORPan = true,
      this.isPan = false})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => CustomImageBuilderV1State();
}

class CustomImageBuilderV1State extends State<CustomImageBuilderV1> {
  late ValueNotifier<String> imagepicked = ValueNotifier("");
  String fileName = "";
  String typeOfImage = "";
  @override
  void initState() {
    if (Uri.parse(widget.initialImage).isAbsolute ||
        widget.initialImage != "") {
      String extension =
          widget.initialImage.substring(widget.initialImage.lastIndexOf("."));

      if (extension == '.pdf') {
        typeOfImage = 'pdf';
      } else {
        typeOfImage = "";
      }
    }

    // TODO: implement initState
    imagepicked = ValueNotifier(widget.initialImage);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: imagepicked,
        builder: (BuildContext context, String hasError, child) {
          if (imagepicked.value == '') {
            return Container(
              child: _getHoirzontalImageUpload2(),
            );
          } else {
            if (widget.type == "image") {
              return Container(child: _getFilemageUpload());
            } else {
              return Container(
                child: _getPdfmageUpload(),
              );
            }
          }
        });
  }

  Widget _getHoirzontalImageUpload() {
    return Container(
      width: SizeConfig.screenWidth - 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.white),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // ImagePickerUtils.showDialogUtil(context,
              //     (imageFile) => {imagepicked.value = imageFile!.path});
            },
            child: Container(
              width: SizeConfig.screenWidth * 0.35,
              height: SizeConfig.screenHeight * 0.15,
              child: Image.asset(widget.image),
              margin: EdgeInsets.symmetric(vertical: 20),
            ),
          ),
          Text(
            widget.value,
            style: CustomTextStyles.boldLargeFonts,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
            child: Text(
              widget.description,
              style: CustomTextStyles.regularMediumGreyFont1,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(DhanvarshaImages.add),
              GestureDetector(
                onTap: () {
                  if (widget.type == "image") {
                    ImagePickerUtils.showDialogUtil(
                        context,
                        (imageFile) => {
                              imagepicked.value = imageFile!.path,
                              fileName = imageFile.name,
                              typeOfImage = imageFile.mimeType != null
                                  ? imageFile.mimeType!
                                  : "",
                            },
                        isAadhaarPan: false,
                        isPan: widget.isPan);
                  } else {
                    ImagePickerUtils.openGallery(context,
                        (imageFile) => {imagepicked.value = imageFile!.path});
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    "Upload",
                    style: CustomTextStyles.boldMediumRedFont,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _getFilemageUpload() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.white),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: GestureDetector(
                  onTap: () {
                    if (typeOfImage == "") {
                      if (imagepicked.value == "" ||
                          !Uri.parse(imagepicked.value).isAbsolute) {
                        if (widget.type == "image") {
                          ImagePickerUtils.showDialogUtil(
                              context,
                              (imageFile) => {
                                    imagepicked.value = imageFile!.path,
                                    fileName = imageFile.name,
                                    typeOfImage = imageFile.mimeType != null
                                        ? imageFile.mimeType!
                                        : "",
                                    widget?.secondImageUpload!()
                                  },
                              isAadhaarPan: false,
                              isPan: widget.isPan);
                        } else {
                          ImagePickerUtils.openGallery(
                              context,
                              (imageFile) => {
                                    imagepicked.value = imageFile!.path,
                                    widget?.secondImageUpload!()
                                  });
                        }
                        ;
                      } else {
                        SuccessfulResponse.showScaffoldMessage(
                            "You can't edit second image", context);
                      }
                    } else {
                      DialogUtils.showInfo(context, imagepicked.value);
                    }
                  },
                  child: Container(
                    width: SizeConfig.screenWidth * 0.35,
                    height: SizeConfig.screenHeight * 0.15,
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: AppColors.lighterGrey),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        typeOfImage == ""
                            ? Uri.parse(imagepicked.value).isAbsolute
                                ? Image.network(
                                    imagepicked.value,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(imagepicked.value),
                                    fit: BoxFit.cover,
                                  )
                            : _getUploadedCard(),
                        Image.asset(
                          DhanvarshaImages.tickmrk,
                          fit: BoxFit.contain,
                          height: 35,
                          width: 35,
                        ),
                        Positioned(
                            right: 0,
                            top: 0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: GestureDetector(
                                onTap: () {
                                  if (imagepicked.value == "" ||
                                      !Uri.parse(imagepicked.value)
                                          .isAbsolute) {
                                    if (widget.type == "image") {
                                      ImagePickerUtils.showDialogUtil(
                                          context,
                                          (imageFile) => {
                                                imagepicked.value =
                                                    imageFile!.path,
                                                fileName = imageFile.name,
                                                typeOfImage =
                                                    imageFile.mimeType != null
                                                        ? imageFile.mimeType!
                                                        : "",
                                                widget?.secondImageUpload!()
                                              },
                                          isAadhaarPan: false,
                                          isPan: widget.isPan);
                                    } else {
                                      ImagePickerUtils.openGallery(
                                          context,
                                          (imageFile) => {
                                                imagepicked.value =
                                                    imageFile!.path,
                                                widget?.secondImageUpload!()
                                              });
                                    }
                                    ;
                                  }
                                },
                                child: Image.asset(
                                  DhanvarshaImages.edit,
                                  fit: BoxFit.contain,
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                            ))
                      ],
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getUploadedCard() {
    return Container(
      width: 100,
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            DhanvarshaImages.tickmrk,
            fit: BoxFit.contain,
            height: 35,
            width: 35,
          )
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    );
  }

  Widget _getHoirzontalImageUpload2() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (imagepicked.value == "") {
              ImagePickerUtils.showDialogUtil(
                  context,
                  (imageFile) => {
                        imagepicked.value = imageFile!.path,
                        fileName = imageFile!.name,
                        typeOfImage = imageFile.mimeType != null
                            ? imageFile.mimeType!
                            : "",
                        widget?.secondImageUpload!()
                      },
                  isAadhaarPan: false,
                  isPan: widget.isPan);
            } else {
              SuccessfulResponse.showScaffoldMessage(
                  "You can't edit second image", context);
            }
          },
          child: Container(
            width: SizeConfig.screenWidth * 0.35,
            height: SizeConfig.screenHeight * 0.15,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.lighterGrey),
            ),
            child: Image.asset(widget.image),
            margin: EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ],
    );
  }

  Widget _getPdfmageUpload() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              width: SizeConfig.screenWidth * 0.35,
              height: SizeConfig.screenHeight * 0.15,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: AppColors.buttonRed),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Image.asset(
                  DhanvarshaImages.tickmrk,
                  height: 45,
                  width: 45,
                  fit: BoxFit.contain,
                ),
              ),
              margin: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
          Text(
            widget.value,
            style: CustomTextStyles.regularsmalleFonts,
          )
        ],
      ),
    );
  }
}
