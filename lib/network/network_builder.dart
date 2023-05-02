import 'package:dhanvarsha/network/typedef.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_application_1/network/model.dart';

class NetworkListnableBuilder<T> extends StatefulWidget{
  final Widget onLoading;
  final Widget InProgress;
  final Widget onAborted;
  final Widget onCompleted;
  final Widget onFailed;
  final ValueNotifier<T> observable;

  const NetworkListnableBuilder({Key? key,required this.onLoading,required this.InProgress,required this.onAborted,required this.onCompleted,required this.observable,required this.onFailed}) : super(key: key);


  @override
  State<StatefulWidget> createState()=>_NetworkListnableState();

}

class _NetworkListnableState extends State<NetworkListnableBuilder>{

  
  @override
  Widget build(BuildContext context) {

    return  ValueListenableBuilder(
              builder: (_,  value,Widget?child) {
                  if(value==NetworkConnectionStatus.InProgress){
                    return widget.onLoading;
                  }else if(value==NetworkConnectionStatus.onCompleted){
                    return widget.onCompleted;
                  }else if(value==NetworkConnectionStatus.onAborted){
                    return widget.onAborted;
                  }else{
                    return widget.onFailed;
                  }
              },
              valueListenable: widget.observable
            );
  }

}