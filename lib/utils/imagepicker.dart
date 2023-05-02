import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dhanvarsha/constants/index.dart';
import 'package:dhanvarsha/navigatorservice/navigatorservice.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/file_config/FileConfig.dart';
import 'package:dhanvarsha/widgets/scanner_flutter/takepicturescreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

typedef onImageSelect = Function(File? imageFile);

typedef onImageFullDetails = Function(XFile? file);

typedef onMulitpleFileSelct = Function(FilePickerResult result);

class ImagePickerUtils {
  static onImageSelect? _imageSelect;

  static getImageFromGallery(onImageFullDetails _imageSelect,
      {bool isCropperRequired = true}) async {
    try {
      print("GETTING IMAGE FROM GALLERY------------------------------> 123");
      final ImagePicker _picker = ImagePicker();

      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );


      // String? localPath = image?.path;

      // print("Image picked !! ");

      bool isSizeFeasible = FileConfig.getFileSize(image!.path);

      if (!isSizeFeasible) {

        if (isCropperRequired &&
            (image.mimeType!.toLowerCase() == 'png' ||
                image.mimeType!.toLowerCase() == 'jpg' ||
                image.mimeType!.toLowerCase() == 'jpeg')) {
          File? croppedFile = await ImageCropper.cropImage(
              sourcePath: image!.path,
              aspectRatioPresets: Platform.isAndroid
                  ? [
                      CropAspectRatioPreset.square,
                      CropAspectRatioPreset.ratio3x2,
                      CropAspectRatioPreset.original,
                      CropAspectRatioPreset.ratio4x3,
                      CropAspectRatioPreset.ratio16x9
                    ]
                  : [
                      CropAspectRatioPreset.original,
                      CropAspectRatioPreset.square,
                      CropAspectRatioPreset.ratio3x2,
                      CropAspectRatioPreset.ratio4x3,
                      CropAspectRatioPreset.ratio5x3,
                      CropAspectRatioPreset.ratio5x4,
                      CropAspectRatioPreset.ratio7x5,
                      CropAspectRatioPreset.ratio16x9
                    ],
              androidUiSettings: AndroidUiSettings(
                  toolbarTitle: 'Dhanvarsha',
                  toolbarColor: Colors.deepOrange,
                  hideBottomControls: true,
                  toolbarWidgetColor: Colors.white,
                  initAspectRatio: CropAspectRatioPreset.original,
                  lockAspectRatio: false),
              iosUiSettings: IOSUiSettings(
                title: 'Dhanvarsha',
              ));
          String fileName = croppedFile!.path.split('/').last;
          XFile? xfile = XFile(croppedFile!.path, mimeType: "", name: fileName);
          _imageSelect(xfile);
        } else {
          _imageSelect(image);
        }
      } else {
        SuccessfulResponse.showScaffoldMessage(FileConfig.FileMessage,
            NavigationService.navigationService.navigatorKey.currentContext!);
      }
      // _imageSelect(image);
    } catch (e) {
      print(e);
      print("Image not picked");
    }
  }

  static getImageFromCamera(onImageFullDetails _imageSelect) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    String? localPath = image?.path;

    _imageSelect(image);
  }

  static getImageFromCameraAndCrop(onImageFullDetails _imageSelect,
      {bool isCropperRequired = true}) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    String? localPath = image?.path;

    bool isSizeFeasible = FileConfig.getFileSize(image!.path);
    if (!isSizeFeasible) {
      if (isCropperRequired) {
        File? croppedFile = await ImageCropper.cropImage(
            sourcePath: image!.path,
            aspectRatioPresets: Platform.isAndroid
                ? [
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio16x9
                  ]
                : [
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio5x3,
                    CropAspectRatioPreset.ratio5x4,
                    CropAspectRatioPreset.ratio7x5,
                    CropAspectRatioPreset.ratio16x9
                  ],
            androidUiSettings: AndroidUiSettings(
                toolbarTitle: 'Dhanvarsha',
                toolbarColor: AppColors.lighterGrey4,
                hideBottomControls: true,
                toolbarWidgetColor: AppColors.black,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            iosUiSettings: IOSUiSettings(
              title: 'Dhanvarsha',
            ));
        String fileName = croppedFile!.path.split('/').last;
        XFile? xfile = XFile(croppedFile!.path, mimeType: "", name: fileName);
        _imageSelect(xfile);
      } else {
        _imageSelect(image);
      }
    } else {
      SuccessfulResponse.showScaffoldMessage(FileConfig.FileMessage,
          NavigationService.navigationService.navigatorKey.currentContext!);
    }

    // _imageSelect(image);
  }

  static showDialogUtil(BuildContext context, onImageFullDetails _imageSelect,
      {bool isAadhaarPan = false,
      bool isPan = false,
      bool isProfilePic = false}) {
    DialogUtils.showImagePickerDialog(context, onImagePressed: () async {
      // getImageFromCamera(_imageSelect);
      if (isPan) {
        if (isProfilePic) {
          getImageFromCameraAndCrop(_imageSelect,
              isCropperRequired: isProfilePic);
        } else {
          final cameras = await availableCameras();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TakePictureScreen(
                        camera: cameras.first,
                        imageSelect: (file) async {
                          File? croppedFile = await ImageCropper.cropImage(
                              sourcePath: file!.path,
                              aspectRatioPresets: Platform.isAndroid
                                  ? [
                                      CropAspectRatioPreset.square,
                                      CropAspectRatioPreset.ratio3x2,
                                      CropAspectRatioPreset.original,
                                      CropAspectRatioPreset.ratio4x3,
                                      CropAspectRatioPreset.ratio16x9
                                    ]
                                  : [
                                      CropAspectRatioPreset.original,
                                      CropAspectRatioPreset.square,
                                      CropAspectRatioPreset.ratio3x2,
                                      CropAspectRatioPreset.ratio4x3,
                                      CropAspectRatioPreset.ratio5x3,
                                      CropAspectRatioPreset.ratio5x4,
                                      CropAspectRatioPreset.ratio7x5,
                                      CropAspectRatioPreset.ratio16x9
                                    ],
                              androidUiSettings: AndroidUiSettings(
                                  toolbarTitle: 'Dhanvarsha',
                                  toolbarColor: AppColors.lighterGrey4,
                                  hideBottomControls: true,
                                  toolbarWidgetColor: AppColors.black,
                                  initAspectRatio:
                                      CropAspectRatioPreset.original,
                                  lockAspectRatio: false),
                              iosUiSettings: IOSUiSettings(
                                title: 'Dhanvarsha',
                              ));

                          print("CROPPED FILE PATH IS");
                          print(croppedFile!.path);

                          XFile fileNew =
                              new XFile(croppedFile!.path, mimeType: '');

                          _imageSelect(fileNew);
                          // String fileName = file!.path.split('/').last;
                          // XFile xFile =
                          //     XFile(file!.path, name: fileName, mimeType: '');
                          // _imageSelect(xFile);
                        },
                      )));
        }
      } else {
        getImageFromCamera(_imageSelect);
      }
    }, onGalleryPressed: () {
      if (!isAadhaarPan) {
        print("INTO THE SINGLE FILE PICKER");
        openSingleFilePicker(_imageSelect, isCropRequired: isPan);
      } else {
        print("INTO THE IMAGE FROM  FILE PICKER");
        getImageFromGallery(_imageSelect, isCropperRequired: isPan);
      }
    });
  }

  static openGallery(context, onImageSelect _imageSelect) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      _imageSelect(file);
    } else {
      print("User Canceled Image Picker");
    }
  }

  static openSingleFilePicker(onImageFullDetails _imageSelect,
      {bool isCropRequired = false}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', "jpeg", 'png'],
        allowMultiple: false);

    if (result != null) {
      // print("Extension Of FIles");
      // print(result!.files.single.extension);
      XFile? file;
      if (result!.files.single.extension == 'pdf') {
        file = new XFile(result!.files.single.path!, mimeType: 'pdf');
      } else {
        file = new XFile(result!.files.single.path!, mimeType: '');
      }

      bool isSizeFeasible = FileConfig.getFileSize(file.path);
      if (!isSizeFeasible) {
        if (file.mimeType == 'pdf') {
          _imageSelect(file);
        } else {
          if (isCropRequired) {
            File? croppedFile = await ImageCropper.cropImage(
                sourcePath: file!.path,
                aspectRatioPresets: Platform.isAndroid
                    ? [
                        CropAspectRatioPreset.square,
                        CropAspectRatioPreset.ratio3x2,
                        CropAspectRatioPreset.original,
                        CropAspectRatioPreset.ratio4x3,
                        CropAspectRatioPreset.ratio16x9
                      ]
                    : [
                        CropAspectRatioPreset.original,
                        CropAspectRatioPreset.square,
                        CropAspectRatioPreset.ratio3x2,
                        CropAspectRatioPreset.ratio4x3,
                        CropAspectRatioPreset.ratio5x3,
                        CropAspectRatioPreset.ratio5x4,
                        CropAspectRatioPreset.ratio7x5,
                        CropAspectRatioPreset.ratio16x9
                      ],
                androidUiSettings: AndroidUiSettings(
                    toolbarTitle: 'Dhanvarsha',
                    toolbarColor: AppColors.lighterGrey4,
                    hideBottomControls: true,
                    toolbarWidgetColor: AppColors.black,
                    initAspectRatio: CropAspectRatioPreset.original,
                    lockAspectRatio: false),
                iosUiSettings: IOSUiSettings(
                  title: 'Dhanvarsha',
                ));

            file = new XFile(croppedFile!.path, mimeType: '');

            _imageSelect(file);
          } else {
            _imageSelect(file);
          }
        }
      } else {
        SuccessfulResponse.showScaffoldMessage(FileConfig.FileMessage,
            NavigationService.navigationService.navigatorKey.currentContext!);
      }
    } else {
      return [];
    }
  }

  static openMultipleFilePicker(context, onMulitpleFileSelct _imageSelect,
      {bool isBankStatements = false}) async {
    if (isBankStatements) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
          allowMultiple: false);

      bool isSizeFeasible = FileConfig.getFileSize(result!.files.single.path!);
      if (!isSizeFeasible) {
        if (result != null) {
          print("Extension Is -->" + result!.files.single.extension!);
          if (result!.files.single.extension!.toUpperCase() == "PDF" ||
              result!.files.single.extension!.toUpperCase().contains("PDF")) {
            _imageSelect(result);
          } else {
            SuccessfulResponse.showScaffoldMessage(
                FileConfig.PdfMessage,
                NavigationService
                    .navigationService.navigatorKey.currentContext!);
          }
        } else {
          return [];
        }
      } else {
        SuccessfulResponse.showScaffoldMessage(FileConfig.FileMessage,
            NavigationService.navigationService.navigatorKey.currentContext!);
      }
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf', "jpeg", 'png'],
          allowMultiple: false);

      bool isSizeFeasible = FileConfig.getFileSize(result!.files.single.path!);
      if (!isSizeFeasible) {
        if (result != null) {
          _imageSelect(result);
        } else {
          return [];
        }
      } else {
        SuccessfulResponse.showScaffoldMessage(FileConfig.FileMessage,
            NavigationService.navigationService.navigatorKey.currentContext!);
      }
    }
  }
}
