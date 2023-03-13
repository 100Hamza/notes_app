import 'package:flutter/material.dart';
import 'package:notes_app/config/front_end_config.dart';
import 'package:notes_app/presentation/elements/custom_text.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        elevation: 15,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  CustomText(text: '09' , textColor: FrontEndConfig.kOnBoardingSecondTextColor),
                  CustomText(text: 'June' , textColor: FrontEndConfig.kOnBoardingSecondTextColor,),
                ],),
                CustomText(text: 'Meeting with Client' , fontSize: 14,textColor: FrontEndConfig.kButtonColor,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
