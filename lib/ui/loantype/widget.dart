import 'package:dhanvarsha/Inheritedwidgets/Inheritedstep.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomFormProgress extends StatefulWidget {

  const CustomFormProgress({Key? key}) : super(key: key);

  @override
  _CustomFormProgressState createState() => _CustomFormProgressState();
}

class _CustomFormProgressState extends State<CustomFormProgress> {
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        itemCount: 4,
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {

          return _getHorizontalList(4, index, context);
        });
  }

  Widget _getHorizontalList(int size, int index, BuildContext contex) {

    final InheritedWrapperState inheritedWrapperState = InheritedWrapper.of(context);
    print("Index is"+index.toString());
    print("Counter is"+inheritedWrapperState.counter.toString());
    return GestureDetector(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 5,
            width: (SizeConfig.screenWidth - (20 * size) - 20) / size,
            color: inheritedWrapperState.counter <= index ? AppColors.lighBox : AppColors.lighterGrey4,
          ),
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color:  inheritedWrapperState.counter <= index ? AppColors.lighBox : AppColors.lighterGrey4,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          )
        ],
      ),
    );
  }


}
