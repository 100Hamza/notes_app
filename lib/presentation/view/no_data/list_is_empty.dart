import 'package:flutter/material.dart';
import 'package:notes_app/presentation/elements/custom_text.dart';
import '../../../config/front_end_config.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/1.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/nodata.png', height: 150 , width: 150,),
            SizedBox(height: 30,),
            CustomText(text: "No Notes :(",textColor: FrontEndConfig.kOnBoardingFirstTextColor, fontSize: 22, ),
            const SizedBox(height: 5,),
            CustomText(text: "You have no task to do." ,textColor: FrontEndConfig.kOnBoardingSecondTextColor, fontSize: 17, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
