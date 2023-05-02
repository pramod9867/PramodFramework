import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/buttonstyles.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/utils/size_config.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required BuildContext context}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nameEditingController = new TextEditingController();

  var isValidatePressed = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BaseView(
      context: context,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 50, 0, 10),
              child: Text(
                'Enter your mobile number',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: Text(
                'We recommend using your personal number. Your phone is your username',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: DVTextField(
                controller: nameEditingController,
                outTextFieldDecoration:
                    BoxDecorationStyles.outTextFieldBoxDecoration,
                inputDecoration: InputDecorationStyles.inputDecorationTextField,
                title: "Mobile Number",
                hintText: "+91",
                errorText: "Type Your Query Here",
                maxLine: 1,
                isValidatePressed: isValidatePressed,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    DhanvarshaImages.tick,
                    height: 30,
                    width: 30,
                  ),
                  Text('I accept all the terms & condition'),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: CustomButton(
                onButtonPressed: () {},
                title: "CONTINUE",
                boxDecoration: ButtonStyles.greyButtonWithCircularBorder,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
