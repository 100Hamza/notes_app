import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:notes_app/config/front_end_config.dart';
import 'package:notes_app/presentation/view/auth/login/login_view.dart';
import 'package:notes_app/presentation/view/home/layout/widget/home_card.dart';


class HomeBody extends StatefulWidget {
  String? groupName;
  HomeBody({this.groupName});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}
bool _isLoading = false;
class _HomeBodyState extends State<HomeBody> {

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              // Container(
              //   height: 100,
              //   decoration: BoxDecoration(
              //     image: const DecorationImage(image: AssetImage('assets/images/top.png') , fit: BoxFit.fill)
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 18.0,horizontal: 8),
              //     child: Row(
              //       children: [
              //         Flexible(
              //           child: SearchBar(hint: 'Search', iconData: Icons.search,),
              //           fit: FlexFit.tight,
              //         ),
              //         SizedBox(width: 20,),
              //         InkWell(
              //           onTap: (){
              //             showNavigationDialog(context, title: "Logout", buttonText: 'Yes', message: 'Do you want to Logout? ', secondButton: "No", navigation: (){
              //               _signOut();
              //             }, isSecondButton: true);
              //           },
              //           child: Container(
              //             height: 40,
              //             width: 40,
              //             decoration: BoxDecoration(
              //               color: FrontEndConfig.kButtonColor,
              //               borderRadius: BorderRadius.circular(50)
              //             ),
              //             child: Icon(Icons.logout , color: Colors.white,),
              //             alignment: Alignment.center,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Container(height: 106, width: MediaQuery.of(context).size.width, color: FrontEndConfig.kButtonColor,),
              HomeCard(groupName: widget.groupName),
            ],
          ),
        ),
      ),
    );
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
