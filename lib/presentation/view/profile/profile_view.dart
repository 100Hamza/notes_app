import 'package:flutter/material.dart';
import 'package:notes_app/config/front_end_config.dart';
import 'package:notes_app/presentation/view/profile/layout/profile_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile") , backgroundColor: FrontEndConfig.kButtonColor),
      body: const ProfileBody()
    );
  }
}
