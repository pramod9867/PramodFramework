import 'package:dhanvarsha/utils/size_config.dart';
import 'package:flutter/material.dart';

class AppAnimation extends StatefulWidget {
  final String? gifPath;
  final int? time;
  final VoidCallback? navigation;

  const AppAnimation({Key? key, this.gifPath="", this.time=5000,required this.navigation}) : super(key: key);

  @override
  _AppAnimationState createState() => _AppAnimationState();
}

class _AppAnimationState extends State<AppAnimation> {

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 5000), () {
      widget.navigation!();

      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondScreen()));
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    //SizeConfig().init(context);
    return Scaffold(
      body: Container(
        child:Image.asset(
          widget.gifPath!,
          height: SizeConfig.screenHeight-SizeConfig.verticalviewinsects,
          width:SizeConfig.screenWidth,
          fit: BoxFit.cover,
          gaplessPlayback: true,


        ),
      ),
    );
  }
}