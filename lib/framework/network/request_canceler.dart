import 'package:dio/dio.dart';

class RequestCanceler{
  static RequestCanceler canceler = RequestCanceler();
CancelToken token = CancelToken();

}