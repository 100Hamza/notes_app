import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/config/front_end_config.dart';
import 'package:notes_app/presentation/view/add_notes/add_notes_view.dart';
import 'package:notes_app/presentation/view/groups/group_view.dart';
import 'package:notes_app/presentation/view/home/layout/home_body.dart';


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 0;
  List _pager = [
    HomeBody(), NotesView() , GroupView()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 60.0,
        items: const [
          Icon(Icons.notes , size: 30, color: Colors.white),
          Icon(Icons.add, size: 30, color: Colors.white),
          Icon(Icons.groups_outlined, size: 30, color: Colors.white),
        ],
        color: FrontEndConfig.kButtonColor,
        buttonBackgroundColor: FrontEndConfig.kButtonColor,
        backgroundColor: Colors.white,
        onTap: (index){
          setState(() {
            _page = index;
            Fluttertoast.showToast(msg: "Index: $_page");
          });
        },
      ),
      body: _pager[_page],
    );
  }
}
