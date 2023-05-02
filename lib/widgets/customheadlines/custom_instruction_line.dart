import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInstruction extends StatelessWidget {
  final String title;
  const CustomInstruction({Key? key, this.title=AppConstants.addressProof}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 1,
        child: Container(
          padding:
          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: [
              // Image.asset(
              //   DhanvarshaImages.i,
              //   height: 25,
              //   width: 25,
              // ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    this.title,
                    style: CustomTextStyles.boldMedium1Font,
                    maxLines: 2,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
