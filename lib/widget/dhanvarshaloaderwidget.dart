import 'package:dhanvarsha/customloader/dhanvarsha_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DhanvarshaLoaderWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _DhanvarshaLoaderState();

}

class _DhanvarshaLoaderState extends State<DhanvarshaLoaderWidget>{
  @override
  Widget build(BuildContext context) {
     return  ValueListenableBuilder(
              builder: (_,  value,Widget?child) {
                  if(DhanvarshaLoader.loader.isLoaderShowing.value){
                    return _getWholeScreenCirularProgress();
                  }else{  

                  return Container();
                  }
              },
              valueListenable: DhanvarshaLoader.loader.isLoaderShowing
            );
  }

   Widget _getWholeScreenCirularProgress() {
    return Container(
      decoration: new BoxDecoration(
          border: new Border.all(
              width: 1,
              color: Colors.transparent), //color is transparent so that it does not blend with the actual color specified

          color: new Color.fromRGBO(
              255, 0, 0, 0.5) // Specifies the background color and the opacity
          ),
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

}