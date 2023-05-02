import 'package:dhanvarsha/bloc/bloc_provider.dart';
import 'package:dhanvarsha/customloader/dhanvarsha_loader.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ApiCalling extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ApiCallingState();
}

class _ApiCallingState extends State<ApiCalling> {
  LoginDataBloc loginDataBloc = LoginDataBloc();

  @override
  void initState() {
    // loginDataBloc.getDataFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("hello world");
    print(loginDataBloc.liveData.value);
      SizeConfig().init(context);
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              loginDataBloc.getDataFromApi();
            },
            child: Container(
              alignment: Alignment.center,
              height: 100,
              width: 100,
              color: Colors.red,
              child: Text("Show Loader",style: TextStyle(fontSize: SizeConfig.textScaleFactor*4),),
            ),
          ),
          GestureDetector(
            onTap: () {
              DhanvarshaLoader.loader.show();
            },
            child: Container(
              alignment: Alignment.center,
              height: SizeConfig.safeBlockHorizontal*50,
              width: SizeConfig.safeBlockHorizontal*50,
              margin: EdgeInsets.symmetric(vertical: 10),
              color: Colors.pink,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text("Hide Loader ss",style: TextStyle(fontSize: 200),),
              ),
            ),
          )
        ],
      ),
    );
  }
}
