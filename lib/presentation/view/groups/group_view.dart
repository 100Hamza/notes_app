import 'package:flutter/material.dart';
import 'package:notes_app/presentation/view/groups/layout/group_body.dart';

class GroupView extends StatefulWidget {
  const GroupView({Key? key}) : super(key: key);

  @override
  State<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GroupBody(),
    );
  }
}
