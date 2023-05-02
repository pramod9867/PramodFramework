import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui_dsa/BaseView.dart';
import 'package:dhanvarsha/utils_dsa/boxdecoration.dart';
import 'package:dhanvarsha/utils_dsa/buttonstyles.dart';
import 'package:dhanvarsha/utils_dsa/customtextstyles.dart';
import 'package:dhanvarsha/utils_dsa/inputdecorations.dart';
import 'package:dhanvarsha/utils_dsa/size_config.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
class OTP extends StatefulWidget {
  const OTP({Key? key, required BuildContext context}) : super(key: key);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {

  GlobalKey key= GlobalKey();
  TextEditingController nameEditingController = new TextEditingController();
  TextEditingController pinEditingController = TextEditingController();
  var isValidatePressed = false;




  @override
  Widget build(BuildContext context) {

    return BaseView(
      context: context,
      body:

      Container(
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: PinInputTextField(

                key: key,
                onSubmit: (text){

                },

                pinLength: 4,
                autoFocus: false,
                decoration: BoxLooseDecoration(
                  radius:Radius.circular(5),
                  strokeColorBuilder: PinListenColorBuilder(
                      Colors.black, Colors.grey),
                  bgColorBuilder: PinListenColorBuilder(
                      Colors.white, Colors.white),
                  strokeWidth: 1,
                  gapSpace:10,
                  obscureStyle: ObscureStyle(
                    isTextObscure: true,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: SizeConfig.screenHeight / 12,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: AppColors.green,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                    child: Image.asset(DhanvarshaImages.tickmrk),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }




}
