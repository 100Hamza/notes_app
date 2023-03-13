import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/navigation_helper/navigation_helper.dart';
import 'package:notes_app/presentation/elements/custom_button.dart';
import 'package:notes_app/presentation/elements/custom_text.dart';
import 'package:notes_app/presentation/view/auth/login/login_view.dart';
import '../../../../config/constants.dart';

import '../../../../config/front_end_config.dart';

class OnboardingBody extends StatelessWidget {
  const OnboardingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Flexible(
               fit: FlexFit.tight,
               child: Image.asset('assets/images/logo.png', height: 150 , width: 150,)),
           Flexible(child: CustomText(text: "Made it Simple ",textColor: FrontEndConfig.kOnBoardingFirstTextColor, fontSize: 22, )),
           const SizedBox(height: 10,),
           CustomText(text: Constants.onBoardingText ,textColor: FrontEndConfig.kOnBoardingSecondTextColor, fontSize: 17, textAlign: TextAlign.center),
           const SizedBox(height: 20,),
           CustomButton(buttonTitle: "Get Started",  color: FrontEndConfig.kButtonColor , onPressed: (){
             NavigationHelper.pushRoute(context, const LoginView());
           }),
        ],
      ),
    );
  }
}
