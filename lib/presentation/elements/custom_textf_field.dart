import 'package:flutter/material.dart';
import 'package:notes_app/config/front_end_config.dart';

class CustomTextField extends StatelessWidget {
  String? hint;
  IconData? iconData;
  bool isIcons, isBorder;
  TextEditingController? controller;
  double? fontSize;
  int maxLines;
  FontWeight? fontWeight;
  Color? fontColor;
  Color hintColor;
  TextInputType? textInputType;
  CustomTextField(
      {this.hint,
      this.iconData,
      this.controller,
      this.fontColor,
      this.maxLines = 1,
      this.fontWeight,
      this.fontSize,
      this.isIcons = true,
      this.isBorder = true ,
      this.hintColor = FrontEndConfig.kNotesTime,
        this.textInputType,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: textInputType,
        controller: controller,
        style: TextStyle(
          color: fontColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        maxLines: maxLines,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: hintColor),
          hintText: hint.toString(),
          prefixIcon: isIcons ? Icon(iconData) : null,
          enabledBorder: isBorder
              ? UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 2,
                      color: FrontEndConfig.kTextFieldEnabledBorderColor),
                )
              : const UnderlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: isBorder
              ? UnderlineInputBorder(
                  borderSide:
                      BorderSide(width: 3, color: FrontEndConfig.kButtonColor),
                )
              : const UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
