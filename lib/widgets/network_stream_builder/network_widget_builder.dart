// @dart=2.9

import 'package:dhanvarsha/framework/network/model.dart';
import 'package:dhanvarsha/framework/network/typedef.dart';
import 'package:dhanvarsha/widgets/network_stream_builder/typedefs.dart';
import 'package:flutter/material.dart';

class NetworkStreamWidgetBuilder<T extends Model> extends StatefulWidget {
  final T observingModel;
  final OnLoadingWidget onLoading;
  final OnSuccessWidget onSuccess;
  final OnFailureWidget onFailure;
  final OnCancelledWidget onCancelled;

  NetworkStreamWidgetBuilder(
    this.observingModel, {
    this.onLoading,
    this.onSuccess,
    this.onFailure,
    this.onCancelled,
  });

  @override
  _NetworkStreamWidgetBuilderState createState() =>
      _NetworkStreamWidgetBuilderState();
}

class _NetworkStreamWidgetBuilderState
    extends State<NetworkStreamWidgetBuilder> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.observingModel.connectionStatusLiveData,
        builder: (_, status, __) {
          if (status == null) {
            return Container();
          }
          switch (status) {
            case NetworkCallConnectionStatus.inProgress:
              {
                if (widget.onLoading != null) {
                  return widget.onLoading(widget.observingModel);
                }
              }
              ;
              break;
            case NetworkCallConnectionStatus.aborted:
              {
                if (widget.onCancelled != null) {
                  return widget.onCancelled(widget.observingModel);
                }
              }
              ;
              break;
            case NetworkCallConnectionStatus.completedSuccessfully:
              {
                if (widget.onSuccess != null) {
                  return widget.onSuccess(widget.observingModel);
                }
              }
              break;
            case NetworkCallConnectionStatus.failed:
              {
                if (widget.onFailure != null) {
                  return widget.onFailure(widget.observingModel);
                }
              }
              ;
              break;
          }
        });
  }
}
