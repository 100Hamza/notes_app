import 'package:flutter/material.dart';
import 'package:notes_app/presentation/view/auth/register/layout/register_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: RegisterBody(),);
  }
}
