import 'dart:io';

class FileConfig {
  static String FileMessage= "File size should not be greater than 5 mb";
  static String PdfMessage="Only pdf file format is allowed";
  static bool getFileSize(String path) {
    File file = new File(path);
    int sizeInBytes = file.lengthSync();
    print("Size In Bytes");
    print(sizeInBytes);

    final kb = sizeInBytes / 1024;
    final mb = kb / 1024;
    // double sizeInMb = (sizeInBytes / (1024 * 1024));

    print("SIZE MB");
    print(mb);
    if (mb > 5) {
      return true;
    } else {
      return false;
    }
  }
}
