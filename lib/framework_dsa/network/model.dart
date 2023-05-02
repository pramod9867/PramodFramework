// @dart=2.9

import 'package:dhanvarsha/framework_dsa/network/typedef.dart';
import 'package:flutter/material.dart';

class Model {
  ValueNotifier<NetworkCallConnectionStatus> _connectionStatusLiveData =
      ValueNotifier(null);

  ValueNotifier<NetworkCallConnectionStatus> get connectionStatusLiveData =>
      _connectionStatusLiveData;

  NetworkCallConnectionStatus get connectionStatus =>
      _connectionStatusLiveData.value;

  void set connectionStatus(NetworkCallConnectionStatus status) {
    _connectionStatusLiveData.value = status;
  }
}
