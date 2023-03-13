import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  String? hint;
  IconData? iconData;
  SearchBar({required this.hint , required this.iconData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 300,
      child: TextField(
        style: TextStyle(
            // color: FrontEndConfig.kTextFieldEnabledBorderColor
        ),
        decoration: InputDecoration(
            hintText: hint.toString(),
            suffixIcon:  Icon(iconData , size: 30,),
            filled: true,
            fillColor: Colors.white,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
        ),
      ),
    );
  }
}
