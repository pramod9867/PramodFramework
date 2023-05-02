import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/model/customerdetails.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/loanreward/loanflowsuccessful.dart';
import 'package:dhanvarsha/ui/loantype/selectloantype.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/buttonstyles.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/utils/size_config.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class VerifyCustNumber extends StatefulWidget {
  final String title;
  final String mobileNumber;
  final String type;
  const VerifyCustNumber(
      {Key? key,
      required BuildContext context,
      this.title = "Verify Customer Number",
      this.mobileNumber = "9664503167",
      this.type = "loan"})
      : super(key: key);

  @override
  _VerifyCustNumberState createState() => _VerifyCustNumberState();
}

class _VerifyCustNumberState extends State<VerifyCustNumber> {
  GlobalKey key = GlobalKey();
  TextEditingController nameEditingController = new TextEditingController();
  TextEditingController pinEditingController = TextEditingController();
  var isValidatePressed = false;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      context: context,
      title: "OTP",
      type: false,
      body: _getBody(),
    );
  }

  Widget _getBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 0, 10),
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text:
                        "Enter the code we have sent the customer via SMS to the mobile number +91 9867106967.",
                    style: TextStyle(color: Colors.grey)),
                TextSpan(text: "Change", style: TextStyle(color: Colors.red)),
              ]),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: PinInputTextField(
              key: key,
              onSubmit: (text) {
                if (widget.type == "loan") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectLoanType(
                        mobileNumber: widget.mobileNumber,
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoanFlowSuccessful(),
                    ),
                  );
                }
              },
              pinLength: 6,
              autoFocus: false,
              decoration: BoxLooseDecoration(
                radius: Radius.circular(5),
                strokeColorBuilder:
                    PinListenColorBuilder(Colors.black, Colors.grey),
                bgColorBuilder:
                    PinListenColorBuilder(Colors.white, Colors.white),
                strokeWidth: 1,
                gapSpace: 10,
                obscureStyle: ObscureStyle(
                  isTextObscure: true,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: CustomButton(
              onButtonPressed: () {
                if (widget.type == "loan") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectLoanType(
                        mobileNumber: widget.mobileNumber,
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoanFlowSuccessful(),
                    ),
                  );
                }
              },
              title: "Submit",
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            child: Text(
              'RESEND CODE',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
