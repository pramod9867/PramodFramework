import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dhanvarsha/navigatorservice/navigatorservice.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/file_config/FileConfig.dart';
import 'package:dhanvarsha/utils_dsa/dialog/dialogutils.dart';
import 'package:dhanvarsha/widgets/scanner_flutter/takepicturescreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef onImageSelect = Function(File? imageFile);
typedef onImageFullDetails = Function(XFile? file);

class ImagePickerUtils {
  static onImageSelect? _imageSelect;

  static getImageFromGallery(
      BuildContext context, onImageSelect _imageSelect) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    String? localPath = image?.path;

    File file = new File(localPath!);
    final bytes = file.readAsBytesSync().lengthInBytes;
    final kb = bytes / 1024;
    final mb = kb / 1024;
    print('kb of image');
    print(kb);
    print('mb ');
    print(mb);
    if (mb > 5) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Image size is more than 5MB")));
    } else {
      _imageSelect(file);
    }
  }

  static getImageFromCamera(
      BuildContext context, onImageSelect _imageSelect) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    String? localPath = image?.path;

    File file = new File(localPath!);
    final bytes = file.readAsBytesSync().lengthInBytes;
    final kb = bytes / 1024;
    final mb = kb / 1024;
    print('kb of image');
    print(kb);
    print('mb ');
    print(mb);
    if (mb > 5) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Image size is more than 5MB")));
    } else {
      _imageSelect(file);
    }

    _imageSelect(file);
  }

  static showDialogUtil(BuildContext context, onImageSelect _imageSelect,
      {bool isPan = false, bool isAllFileSupported = false}) {
    DialogUtils.showImagePickerDialog(context, onImagePressed: () async {
      if (isPan) {
        final cameras = await availableCameras();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TakePictureScreen(
                      camera: cameras.first,
                      imageSelect: (file) {
                        // String fileName = file!.path.split('/').last;
                        // File xFile =
                        //     XFile(file!.path, name: fileName, mimeType: '');
                        _imageSelect(file);
                      },
                    )));
      } else {
        getImageFromCamera(context, _imageSelect);
      }
    }, onGalleryPressed: () {
      getImageFromGallery(context, _imageSelect);
    });
  }

  static openSingleFilePicker(onImageFullDetails _imageSelect) async {
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
        _imageSelect(file);
      } else {
        SuccessfulResponse.showScaffoldMessage(FileConfig.FileMessage,
            NavigationService.navigationService.navigatorKey.currentContext!);
      }
    } else {
      return [];
    }
  }
}
