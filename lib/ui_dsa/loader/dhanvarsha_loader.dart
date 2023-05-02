import 'package:dhanvarsha/ui_dsa/loader/CustomLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DhanvarshaLoader extends StatefulWidget {
  const DhanvarshaLoader({Key? key}) : super(key: key);

  @override
  _DhanvarshaLoaderState createState() => _DhanvarshaLoaderState();
}

class _DhanvarshaLoaderState extends State<DhanvarshaLoader> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CustomLoader.customloaderbuilder.loader,
        builder: (BuildContext context, bool value, Widget? child) {
          if (CustomLoader.customloaderbuilder.loader.value) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Container(
              child: Center(

                  // child: Text("hide Loader"),
                  ),
            );
          }
        });
  }
}
