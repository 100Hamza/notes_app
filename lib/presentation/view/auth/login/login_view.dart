import 'package:flutter/material.dart';
import 'package:notes_app/presentation/elements/custom_textf_field.dart';
import 'package:notes_app/presentation/view/auth/login/layout/login_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginBody()
    );
  }
}
