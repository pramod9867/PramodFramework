import 'dart:io';
import 'dart:math';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as IMG;

class ImageProcessor {
  static Future<File> cropSquare(
      String srcFilePath, String destFilePath, bool flip) async {
    var bytes = await File(srcFilePath).readAsBytes();
    IMG.Image? src = IMG.decodeImage(bytes);

    print("into the processing");

    print("Size OF IMage");
    print("width :"+src!.width.toString());
    print("height :"+src!.height.toString());


    var cropSize = min(src!.width-50, src.height);
    int offsetX = (src.width - min(src.width, src.height)) ~/ 2;
    int offsetY = (src.height - min(src.width, src.height)) ~/ 2;

    print("width :"+src!.width.toString());
    print("height :"+src!.height.toString());
    print("offset X :"+offsetX.toString());
    print("offset Y :"+offsetY.toString());
    print("Crop Size :"+cropSize.toString());


    IMG.Image destImage =
        IMG.copyCrop(src, offsetX, offsetY, src!.width-50, 450);

    if (flip) {
      destImage = IMG.flipVertical(destImage);
    }

    var jpg = IMG.encodeJpg(destImage);
    File newFile = await File(destFilePath).writeAsBytes(jpg);

    print("NEW PATH");
    print(newFile.path);
    return newFile;
  }
}
