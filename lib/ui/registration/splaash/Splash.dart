import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Spalsh extends StatelessWidget {
  const Spalsh({Key? key, required BuildContext context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BaseView(
      context: context,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                DhanvarshaImages.dhanvarshalogo,
                width: SizeConfig.screenWidth / 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text('2,346 Loan Issued',
                style: CustomTextStyles.regularMediumFont,
              ),
            ),
            Text('1,980 Happy Customers',
              style: CustomTextStyles.regularMediumFont,
            ),
          ],
        ),
      ),
    );
  }
}
