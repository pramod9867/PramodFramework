import 'dart:convert';
import 'dart:typed_data';

import 'package:dhanvarsha/utils/encryption/aes_pkcs7padding/aes_encryption_helper.dart';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/export.dart';

class EncryptData {
//for AES Algorithms

  static Encrypted? encrypted;
  static String keySTR = "1234123412341234"; //16 byte
  static String ivSTR = "123456";
  static String encryptAES(plainText) {
    final key = Key.fromUtf8('1234123412341234');
    final iv = IV.fromUtf8('1234123412341234');

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
    final encrypted = encrypter.encrypt(plainText, iv: iv);

    return encrypted.base64;
  }

  static String decryptAES(plainText) {
    final key = Key.fromUtf8('1234123412341234');
    final iv = IV.fromUtf8('1234123412341234');

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc,padding: 'PKCS7'));
    String decrypted = encrypter.decrypt64(plainText!, iv: iv);
    print(decrypted);
    return decrypted;
  }
}
