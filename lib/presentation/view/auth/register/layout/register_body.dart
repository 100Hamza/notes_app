
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:notes_app/navigation_helper/navigation_helper.dart';
import 'package:notes_app/presentation/view/auth/login/login_view.dart';
import '../../../../../config/front_end_config.dart';
import '../../../../elements/custom_button.dart';
import '../../../../elements/custom_textf_field.dart';
import '../../widget/custom_rich_text.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({Key? key}) : super(key: key);

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

TextEditingController _userNameController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _mailController = TextEditingController();
bool isLoading = false;
class _RegisterBodyState extends State<RegisterBody> {
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
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
              hint: 'Enter User Name',
              iconData: Icons.person,
            )),
            CustomTextField(
              controller: _mailController,
              hint: "Enter Email",
              iconData: Icons.mail,
            ),
            CustomTextField(
              controller: _passwordController,
              hint: "Enter Password",
              iconData: Icons.lock,
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
                buttonTitle: "Signup",
                color: FrontEndConfig.kButtonColor,
                onPressed: () {
                  if(_userNameController.toString().isEmpty || _mailController.toString().isEmpty || _passwordController.toString().isEmpty)
                    {
                      Fluttertoast.showToast(msg: "Each Field must be filled");
                    }
                  else
                    {
                      _createAccount();
                    }
                }),
            const SizedBox(
              height: 20,
            ),
            CustomRichText(
              firstText: 'Already Have an Account',
              secondText: ' Login',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  NavigationHelper.pushRoute(context, LoginView());
                },
            ),
          ],
        ),
      ),
    );
  }
  void _createAccount() async
  {
   try{
     _isLoadingTrue();
     await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: _mailController.text, password: _passwordController.text).then((value) {
       var id = FirebaseAuth.instance.currentUser!.uid;
       print("User ID $id");
     }).
     whenComplete(() {
       _isLoadingFalse();
       NavigationHelper.pushRoute(context, LoginView());
     });
   }
   catch(e)
    {
      Fluttertoast.showToast(msg: "Error: $e");
      _isLoadingFalse();
    }
  }

  void _isLoadingTrue()
  {
    setState(() {
      isLoading = true;
    });
  }

  void _isLoadingFalse()
  {
    setState(() {
      isLoading = false;
    });
  }
}
