import 'package:dhanvarsha/windowbuilder/dv_windowbuilder.dart';
import 'package:flutter/cupertino.dart';

class Baseclass extends StatefulWidget{
  final Widget body;

  const Baseclass({Key? key,required this.body}) : super(key: key);



  @override
  State<StatefulWidget> createState() =>_BaseClassState();

}

class _BaseClassState extends State<Baseclass>{
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:_getGenerateList(),
    );
  }

  _getGenerateList(){
    List<Widget> appScreens=[];
    appScreens.add(widget.body);

  
  for(int i=0;i<FlutterWindowBuilder.windowBuilder.windows.length;i++){
    appScreens.add(FlutterWindowBuilder.windowBuilder.windows[i]);
  }

print("App Screen Are....");
   print(appScreens);
   return appScreens;
  }

}