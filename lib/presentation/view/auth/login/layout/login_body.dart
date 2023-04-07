import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:notes_app/presentation/elements/custom_textf_field.dart';
import 'package:notes_app/presentation/view/auth/register/register_view.dart';
import 'package:notes_app/presentation/view/auth/widget/custom_rich_text.dart';
import 'package:notes_app/presentation/view/home/home_view.dart';

import '../../../../../config/front_end_config.dart';
import '../../../../../navigation_helper/navigation_helper.dart';
import '../../../../elements/custom_button.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

TextEditingController _emailController = TextEditingController();
TextEditingController _passController = TextEditingController();
bool _isLoading = false;
class _LoginBodyState extends State<LoginBody> {
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                fit: FlexFit.tight,
                child: Image.asset(
                  'assets/images/login.png',
                  height: 150,
                  width: 150,
                )),
            Flexible(
                child: CustomTextField(
                  textInputType: TextInputType.emailAddress,
                  controller: _emailController,
                  hint: 'Enter Email',
                  iconData: Icons.person,
            )),
            CustomTextField(
              controller: _passController,
              hint: 'Enter Password',
              iconData: Icons.lock,
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
                buttonTitle: "Login",
                color: FrontEndConfig.kButtonColor,
                onPressed: () {
                  if(_emailController.text.isEmpty || _passController.text.isEmpty)
                    {
                      Fluttertoast.showToast(msg: "Fields can't be emppty");
                    }
                  else{
                    _login();
                  }
                }),
            const SizedBox(
              height: 20,
            ),
            CustomRichText(
              firstText: 'Don\'t have an Account?',
              secondText: ' SIGNUP',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  NavigationHelper.pushRoute(
                    context,
                    RegisterView(),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }

  void _login() async
  {
    try{
      _isLoadingTrue();
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passController.text).then((value){
        _isLoadingFalse();
        NavigationHelper.pushRoute(context, HomeView());
      });
    }
    catch(e)
    {
      Fluttertoast.showToast(msg: 'Error: $e');
      _isLoadingFalse();
    }
  }



  void _isLoadingTrue()
  {
    setState(() {
      _isLoading = true;
    });
  }

  void _isLoadingFalse()
  {
    setState(() {
      _isLoading = false;
    });
  }
}
