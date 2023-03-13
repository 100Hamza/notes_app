import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future showNavigationDialog(BuildContext context, {
  required String title,
  required String buttonText,
  required String message,
  required String secondButton,
  required VoidCallback navigation,
  required bool isSecondButton}) async {
  showDialog(
    barrierDismissible: false,
    context: context, builder: (context) {
    return CupertinoAlertDialog(
      title: Text(
        title.toString(),
        style: TextStyle(
            color: Colors.green[900]
        ),

      ),
      content: Text(message),
      actions: [
        if(isSecondButton)
          TextButton(onPressed: () {
          Navigator.pop(context);
        }, child: Text(secondButton)),
        TextButton(onPressed: navigation, child: Text(buttonText),)
      ],
    );
  });
}