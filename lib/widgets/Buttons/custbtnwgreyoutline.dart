import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:flutter/material.dart';


class custbtnwgreyoutline extends StatefulWidget{

  final String title;
  final VoidCallback onButtonPressed;
  final double widthScale;
  final BoxDecoration boxDecoration;

  custbtnwgreyoutline({Key? key,this.title="Sample",this.widthScale=1,required this.onButtonPressed,this.boxDecoration=ButtonStyles.greyButtonWithCircularBorder}):super(key: key);

  @override
  State<StatefulWidget> createState()=>_custbtnwgreyoutline();

}

class _custbtnwgreyoutline extends State<custbtnwgreyoutline>{
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: widget.onButtonPressed,
      child:Container(
        height: SizeConfig.screenHeight*0.075,
        width: widget.widthScale*SizeConfig.screenWidth,
        decoration: widget.boxDecoration,
        margin:EdgeInsets.all(5),
        child: Center(
          child: Text(widget.title,style:CustomTextStyles.buttonBlackTextStyle,),
        ),
      ));
  }

}