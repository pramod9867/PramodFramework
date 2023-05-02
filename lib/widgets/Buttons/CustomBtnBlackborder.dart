import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:flutter/material.dart';


class CustomBtnBlackborder extends StatefulWidget{

  final String title;
  final VoidCallback onButtonPressed;
  final double widthScale;
  final BoxDecoration boxDecoration;
  final bool Pressedflag ;

  CustomBtnBlackborder({Key? key,this.Pressedflag=false,this.title="Sample",this.widthScale=1,required this.onButtonPressed,this.boxDecoration=ButtonStyles.redButtonWithCircularBorder}):super(key: key);

  @override
  State<StatefulWidget> createState()=>_CustomBtnBlackborder();

}

class _CustomBtnBlackborder extends State<CustomBtnBlackborder>{
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: widget.onButtonPressed,
      child:Container(
        height: SizeConfig.screenHeight*0.070,
        width: widget.widthScale*SizeConfig.screenWidth,
        decoration: widget.Pressedflag?BoxDecorationStyles.outButtonOfRedBox:widget.boxDecoration,
        alignment: Alignment.center,
          child: Text(widget.title,style:CustomTextStyles.buttonTextStyleGotham,)
         )
      );

  }

}