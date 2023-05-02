import 'package:dhanvarsha/network/typedef.dart';
import 'package:flutter/material.dart';


class Model {
  ValueNotifier<NetworkConnectionStatus> _connectionStatusLiveData =
      ValueNotifier(null!!);

  ValueNotifier<NetworkConnectionStatus> get connectionStatusLiveData =>
      _connectionStatusLiveData;

  NetworkConnectionStatus get connectionStatus =>
      _connectionStatusLiveData.value;

  void set connectionStatus(NetworkConnectionStatus status) {
    _connectionStatusLiveData.value = status;
  }
}
