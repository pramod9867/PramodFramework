import 'package:flutter/services.dart';

class EncryptionUtils{
  static const platform =
  const MethodChannel('flutter.native/encryption_utility');
  static const platformdecrypt =
  const MethodChannel('flutter.native/decryption_utility');

  static Future<String?> getEncryptedText(
      String plainText) async {
    try {
      print(platform.name);
      final String result = await platform.invokeMethod("aes_encrypt", {
        "text": plainText,
      });

      return result;
    } on PlatformException catch (e) {
      return e.message;
    }
  }

  static Future<String?> decryptString(
      String plainText) async {
    try {
      final String result = await platformdecrypt.invokeMethod("aes_decrypt", {
        "text": plainText,
      });
      // print(result);
      return result;
    } on PlatformException catch (e) {
      return e.message;
    }
  }

}