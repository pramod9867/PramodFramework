import 'package:dhanvarsha/ui_dsa/registration/appreview/Appreview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key, required BuildContext context})
      : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl:
            'https://mgenius.in/Dhanvarsha/Payment/MakePayment?DsaId=gI0X0Bt8L7Ywg0vFNXWxrA==',
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (String url) {
          print('Page finished loading: $url');

          if (url == 'https://mgenius.in/Dhanvarsha/Webhook/PaymentSuccess/') {
            new Future.delayed(const Duration(seconds: 5), () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Payment Successful ")));
              Navigator.push(
                context,
                MaterialPageRoute(
                    //builder: (context) => Login(
                    builder: (context) => Appreview(
                          context: context,
                        )),
              );
            });
          } else {
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //     content: Text(
            //         "Please Try Again")));
          }
        },
      ),
    );
  }
}
