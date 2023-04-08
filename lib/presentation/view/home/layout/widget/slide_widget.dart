import 'package:flutter/material.dart';
import 'package:notes_app/presentation/elements/custom_text.dart';

class SlideWidget extends StatelessWidget {
  Color? backgroundColor;
  String? labelText;
  IconData? icon;
  MainAxisAlignment? mainAxisAlignment;
  EdgeInsetsGeometry? iconPadding;
  SlideWidget({required this.backgroundColor ,required this.labelText, required this.icon , required this.mainAxisAlignment , required this.iconPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: iconPadding,
        color: backgroundColor,
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: mainAxisAlignment!,
            children: [
              Icon(icon , color: Colors.white,),
              SizedBox(width: 5,),
              CustomText(text: labelText, fontSize: 16, fontWeight: FontWeight. w600, textColor: Colors.white),
        ]),
      ),
    );
  }
}
