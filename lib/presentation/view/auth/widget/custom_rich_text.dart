import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../config/front_end_config.dart';
class CustomRichText extends StatelessWidget {
  String? firstText, secondText;
  GestureRecognizer? recognizer;
  CustomRichText({required this.firstText , required this.secondText , required this.recognizer});
  @override
  Widget build(BuildContext context) {
    return  RichText(
      text: TextSpan(
        text: firstText.toString(),
        style: TextStyle(color: FrontEndConfig.kAccountTextColor),
        children: [
          TextSpan(
            text: secondText.toString(),
            style: TextStyle(color: FrontEndConfig.kAuthTextColor , fontWeight: FontWeight.bold),
            recognizer: recognizer
          )
        ],
      ),
    );
  }
}
