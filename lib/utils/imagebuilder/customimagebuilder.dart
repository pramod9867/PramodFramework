import 'dart:convert';
import 'dart:io';

import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilderv1.dart';
import 'package:dhanvarsha/utils/imagepicker.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomImageBuilder extends StatefulWidget {
  final String value;
  final String type;
  final bool isPan;
  final bool isAadhaarORPan;
  final String image;
  final String newAddress;
  final String description;
  final Widget? dropdown;
  final String? subtitle;
  final bool isAadhaarImage;
  final bool isRental;
  final bool isProfilePic;
  final String initialImage;
  final bool isAadhaarVisible;
  final bool isRentalUpload;
  final String no;
  final String subtitleString;
  final String subtitleImage;
  final String secondInitialImage;
  final VoidCallback? firstImageUploaded;
  final VoidCallback? secondImageUploaded;
  final bool isImageShown;
  final GlobalKey<CustomImageBuilderV1State>? anotherImageKey;
  const CustomImageBuilder(
      {Key? key,
      this.value = "Front View",
      this.image = DhanvarshaImages.pan,
      this.type = "image",
      this.description = "",
      this.isAadhaarImage = false,
      this.no = "",
      this.subtitleString = "UPLOAD",
      this.subtitleImage = DhanvarshaImages.uploadnew,
      this.anotherImageKey,
      this.firstImageUploaded,
      this.secondImageUploaded,
      this.isAadhaarVisible = true,
      this.dropdown,
      this.isRental = false,
      this.isImageShown = true,
      this.initialImage = "",
      this.secondInitialImage = "",
      this.isRentalUpload = false,
      this.newAddress = "",
      this.isAadhaarORPan = false,
      this.isPan = false,
      this.isProfilePic = false,
      this.subtitle = "Document Added"})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => CustomImageBuilderState();
}

class CustomImageBuilderState extends State<CustomImageBuilder> {
  late ValueNotifier<String> imagepicked;

  String fileName = "";
  String typeOfImage = "";
  late bool isRentalUpload;

  @override
  void initState() {
    // TODO: implement initState

    print("File URL");
    print(widget.initialImage);

    if (Uri.parse(widget.initialImage).isAbsolute ||
        widget.initialImage != "") {
      String extension =
          widget.initialImage.substring(widget.initialImage.lastIndexOf("."));

      print("Extension is");
      print(extension);
      if (extension == '.pdf') {
        typeOfImage = 'pdf';
      } else {
        typeOfImage = "";
      }
    }

    print("Type Of Image");

    print(typeOfImage);

    imagepicked = ValueNotifier(widget.initialImage);

    imagepicked.addListener(() {
      print(imagepicked.value);
    });
    isRentalUpload = widget.isRentalUpload;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: imagepicked,
        builder: (BuildContext context, String hasError, child) {
          if (imagepicked.value == '') {
            return Container(
                child: widget.isRental
                    ? _getHoirzontalRentalUpload()
                    : _getHoirzontalImageUpload());
          } else {
            if (widget.type == "image") {
              return Container(
                  child: widget.isRental
                      ? _getRentalUploaded()
                      : _getFilemageUpload());
            } else {
              return Container(
                child: _getPdfmageUpload(),
              );
            }
          }
        });
  }

  Widget _getHoirzontalImageUpload() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: SizeConfig.screenWidth - 30,
        padding: EdgeInsets.symmetric(vertical: widget.isImageShown ? 0 : 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColors.white),
        child: Column(
          children: [
            widget.isImageShown
                ? GestureDetector(
                    onTap: () {
                      // ImagePickerUtils.showDialogUtil(context,
                      //     (imageFile) => {imagepicked.value = imageFile!.path});
                    },
                    child: Container(
                      width: SizeConfig.screenWidth * 0.35,
                      height: SizeConfig.screenHeight * 0.15,
                      child: Image.asset(
                        widget.image,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 20),
                    ),
                  )
                : Container(),
            widget.isAadhaarVisible
                ? Text(
                    widget.value,
                    style: CustomTextStyles.boldLargeFontsGotham,
                    textAlign: TextAlign.center,
                  )
                : Container(),
            widget.isAadhaarVisible
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
                    child: Text(
                      widget.description,
                      style: CustomTextStyles.regularMediumGreyFont1Gotham,
                      textAlign: TextAlign.center,
                    ),
                  )
                : Container(),
            !widget.isAadhaarVisible
                ? Text(
                    widget.value,
                    style: CustomTextStyles.boldLargeFontsGotham,
                  )
                : Container(),
            !widget.isAadhaarVisible
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      widget.newAddress,
                      style: CustomTextStyles.regularSmallGreyFont1Gotham,
                      textAlign: TextAlign.center,
                    ),
                  )
                : Container(),
            !widget.isAadhaarVisible ? widget.dropdown! : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.subtitleImage == DhanvarshaImages.uploadnew
                    ? Image.asset(widget.subtitleImage)
                    : Image.asset(
                        widget.subtitleImage,
                        height: 20,
                        width: 20,
                      ),
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
                                print("type of image checking user ...."),
                                print(typeOfImage),
                                if (widget.firstImageUploaded != null)
                                  {widget?.firstImageUploaded!()}
                              },
                          isAadhaarPan: widget.isAadhaarORPan,
                          isPan: widget.isPan,
                          isProfilePic: widget.isProfilePic);
                    } else {
                      ImagePickerUtils.openGallery(
                          context,
                          (imageFile) => {
                                imagepicked.value = imageFile!.path,
                                widget?.firstImageUploaded!()
                              });
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      widget.subtitleString,
                      style: CustomTextStyles.boldMediumRedFontGotham,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _getHoirzontalRentalUpload() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: SizeConfig.screenWidth - 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColors.white),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Name on bill",
                              style: CustomTextStyles.boldLargeFonts,
                            ),
                            Text(
                              "Bill is not on my name",
                              style: CustomTextStyles.regularSmallGreyFont,
                            ),
                          ],
                        ),
                      ),
                      FlutterSwitch(
                        width: 55,
                        height: 35,
                        activeColor: AppColors.buttonRed,
                        value: isRentalUpload,
                        onToggle: (value) {
                          setState(() {
                            isRentalUpload = value;
                          });
                          print(value);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            isRentalUpload
                ? Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Divider(),
                        ),
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
                        widget.isAadhaarVisible
                            ? Text(
                                widget.value,
                                style: CustomTextStyles.boldLargeFontsGotham,
                              )
                            : Container(),
                        widget.isAadhaarVisible
                            ? Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 7),
                                child: Text(
                                  widget.description,
                                  style:
                                      CustomTextStyles.regularMediumGreyFont1Gotham,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Container(),
                        !widget.isAadhaarVisible
                            ? Text(
                                "Proof Of Address",
                                style: CustomTextStyles.boldLargeFonts,
                              )
                            : Container(),
                        !widget.isAadhaarVisible
                            ? widget.dropdown!
                            : Container(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(widget.subtitleImage),
                            GestureDetector(
                              onTap: () {
                                if (widget.type == "image") {
                                  ImagePickerUtils.showDialogUtil(
                                      context,
                                      (imageFile) => {
                                            imagepicked.value = imageFile!.path,
                                            fileName = imageFile.name,
                                            typeOfImage =
                                                imageFile.mimeType != null
                                                    ? imageFile.mimeType!
                                                    : "",
                                            widget?.firstImageUploaded!()
                                          },
                                      isAadhaarPan: widget.isAadhaarORPan,
                                      isPan: widget.isPan,
                                      isProfilePic: widget.isProfilePic);
                                } else {
                                  ImagePickerUtils.openGallery(
                                      context,
                                      (imageFile) => {
                                            imagepicked.value = imageFile!.path,
                                            widget?.firstImageUploaded!()
                                          });
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text(
                                  widget.subtitleString,
                                  style: CustomTextStyles.boldMediumRedFontGotham,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget _getFilemageUpload() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: SizeConfig.screenWidth - 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                widget.value.replaceAll("Upload", ""),
                style: CustomTextStyles.boldLargeFontsGotham,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                widget.description,
                style: CustomTextStyles.regularMediumGreyFont1Gotham,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Divider(),
            ),
            Container(
              child: Text(
                widget.subtitle!,
                style: CustomTextStyles.boldMediumFontGotham,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () {
                      if (typeOfImage == "") {
                        if (widget.type == "image") {
                          ImagePickerUtils.showDialogUtil(
                              context,
                              (imageFile) => {
                                    imagepicked.value = imageFile!.path,
                                    fileName = imageFile.name,
                                    typeOfImage = imageFile.mimeType != null
                                        ? imageFile.mimeType!
                                        : "",
                                    if (widget.firstImageUploaded != null)
                                      {
                                        widget?.firstImageUploaded!(),
                                      }
                                  },
                              isAadhaarPan: widget.isAadhaarORPan,
                              isPan: widget.isPan,
                              isProfilePic: widget.isProfilePic);
                        } else {
                          ImagePickerUtils.openGallery(
                              context,
                              (imageFile) => {
                                    imagepicked.value = imageFile!.path,
                                    if (widget.firstImageUploaded != null)
                                      {
                                        widget?.firstImageUploaded!(),
                                      }
                                  });
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
                                                if (widget.firstImageUploaded !=
                                                    null)
                                                  {
                                                    widget
                                                        ?.firstImageUploaded!(),
                                                  }
                                              },
                                          isAadhaarPan: widget.isAadhaarORPan,
                                          isPan: widget.isPan,
                                          isProfilePic: widget.isProfilePic);
                                    } else {
                                      ImagePickerUtils.openGallery(
                                          context,
                                          (imageFile) => {
                                                imagepicked.value =
                                                    imageFile!.path,
                                                if (widget.firstImageUploaded !=
                                                    null)
                                                  {
                                                    widget
                                                        ?.firstImageUploaded!(),
                                                  }
                                              });
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
                Container(
                  margin: widget.isAadhaarImage
                      ? EdgeInsets.symmetric(horizontal: 5)
                      : EdgeInsets.symmetric(horizontal: 0),
                  child: widget.isAadhaarImage
                      ? CustomImageBuilderV1(
                          secondImageUpload: widget.secondImageUploaded,
                          image: DhanvarshaImages.poa,
                          isAadhaarORPan: false,
                          key: widget.anotherImageKey,
                          initialImage: widget.secondInitialImage,
                          isPan: widget.isPan,
                        )
                      : Container(),
                )
              ],
            ),
            widget.no != "" ? Container() : Container(),
            !widget.isAadhaarVisible ? widget.dropdown! : Container(),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Divider(),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.subtitleImage == DhanvarshaImages.uploadnew
                      ? Image.asset(widget.subtitleImage)
                      : Image.asset(
                          widget.subtitleImage,
                          height: 20,
                          width: 20,
                        ),
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
                                  print("type of image"),
                                  print(imageFile.mimeType),
                                  if (widget.firstImageUploaded != null)
                                    {widget?.firstImageUploaded!()}
                                },
                            isAadhaarPan: widget.isAadhaarORPan,
                            isPan: widget.isPan,
                            isProfilePic: widget.isProfilePic);
                      } else {
                        ImagePickerUtils.openGallery(
                            context,
                            (imageFile) => {
                                  imagepicked.value = imageFile!.path,
                                  if (widget.firstImageUploaded != null)
                                    {widget?.firstImageUploaded!()}
                                });
                      }
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text(
                        widget.subtitleString,
                        style: CustomTextStyles.boldMediumRedFontGotham,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getRentalUploaded() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: SizeConfig.screenWidth - 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColors.white),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Name on bill",
                              style: CustomTextStyles.boldLargeFontsGotham,
                            ),
                            Text(
                              "Bill is not on my name",
                              style: CustomTextStyles.regularSmallGreyFontGotham,
                            ),
                          ],
                        ),
                      ),
                      FlutterSwitch(
                        width: 55,
                        height: 35,
                        activeColor: AppColors.buttonRed,
                        value: isRentalUpload,
                        onToggle: (value) {
                          setState(() {
                            isRentalUpload = value;
                          });
                          print(value);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            isRentalUpload
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(),
                  )
                : Container(),
            isRentalUpload
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
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
                                        widget?.firstImageUploaded!()
                                      },
                                  isAadhaarPan: widget.isAadhaarORPan,
                                  isPan: widget.isPan,
                                  isProfilePic: widget.isProfilePic);
                            } else {
                              ImagePickerUtils.openGallery(
                                  context,
                                  (imageFile) => {
                                        imagepicked.value = imageFile!.path,
                                        widget?.firstImageUploaded!(),
                                      });
                            }
                          },
                          child: Container(
                            width: SizeConfig.screenWidth * 0.35,
                            height: SizeConfig.screenHeight * 0.15,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
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
                                )
                              ],
                            ),
                            margin: EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                      Container(
                        margin: widget.isAadhaarImage
                            ? EdgeInsets.symmetric(horizontal: 5)
                            : EdgeInsets.symmetric(horizontal: 0),
                        child: widget.isAadhaarImage
                            ? CustomImageBuilderV1(
                                secondImageUpload: widget.secondImageUploaded,
                                image: DhanvarshaImages.poa,
                                key: widget.anotherImageKey,
                                isPan: widget.isPan,
                                isAadhaarORPan: false,
                              )
                            : Container(),
                      )
                    ],
                  )
                : Container(),
            widget.no != ""
                ? Text(
                    widget.no,
                    style: CustomTextStyles.boldLargeFontsGotham,
                  )
                : Container(),
            !widget.isAadhaarVisible ? widget.dropdown! : Container(),
          ],
        ),
      ),
    );
  }

  Widget _getHoirzontalImageUpload2() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            ImagePickerUtils.showDialogUtil(
                context,
                (imageFile) => {
                      imagepicked.value = imageFile!.path,
                      typeOfImage =
                          imageFile.mimeType != null ? imageFile.mimeType! : "",
                    },
                isAadhaarPan: widget.isAadhaarORPan,
                isPan: widget.isPan,
                isProfilePic: widget.isProfilePic);
          },
          child: Container(
            width: SizeConfig.screenWidth * 0.35,
            height: SizeConfig.screenHeight * 0.15,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.black),
            ),
            child: Image.asset(DhanvarshaImages.card),
            margin: EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ],
    );
  }

  Widget _getPdfmageUpload() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: SizeConfig.screenWidth - 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColors.white),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () {
                      if (widget.type == "image") {
                        ImagePickerUtils.showDialogUtil(
                            context,
                            (imageFile) => {
                                  imagepicked.value = imageFile!.path,
                                  typeOfImage = imageFile.mimeType != null
                                      ? imageFile.mimeType!
                                      : "",
                                },
                            isAadhaarPan: widget.isAadhaarORPan,
                            isPan: widget.isPan,
                            isProfilePic: widget.isProfilePic);
                      } else {
                        ImagePickerUtils.openGallery(
                            context,
                            (imageFile) =>
                                {imagepicked.value = imageFile!.path});
                      }
                    },
                    child: Container(
                      width: SizeConfig.screenWidth * 0.35,
                      height: SizeConfig.screenHeight * 0.15,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                      ),
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
                      margin: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                Container(
                  margin: widget.isAadhaarImage
                      ? EdgeInsets.symmetric(horizontal: 5)
                      : EdgeInsets.symmetric(horizontal: 0),
                  child: widget.isAadhaarImage
                      ? CustomImageBuilderV1(
                          secondImageUpload: widget.secondImageUploaded,
                          image: DhanvarshaImages.poa,
                          key: widget.anotherImageKey,
                          isPan: widget.isPan,
                          isAadhaarORPan: false,
                        )
                      : Container(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(widget.subtitleImage),
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
                          isAadhaarPan: widget.isAadhaarORPan,
                          isProfilePic: widget.isProfilePic,
                          isPan: widget.isPan);
                    } else {
                      ImagePickerUtils.openGallery(context,
                          (imageFile) => {imagepicked.value = imageFile!.path});
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      widget.subtitleString,
                      style: CustomTextStyles.boldMediumRedFontGotham,
                    ),
                  ),
                )
              ],
            ),
            Text(
              widget.no,
              style: CustomTextStyles.boldLargeFontsGotham,
            ),
          ],
        ),
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
}
