import 'package:flutter/material.dart';
import 'package:notes_app/presentation/view/groups/layout/group_body.dart';
class GroupView extends StatelessWidget {
  const GroupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GroupBody(),
    );
  }
}
