import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:notes_app/config/front_end_config.dart';
import 'package:notes_app/presentation/elements/navigation_dialog.dart';
import 'package:notes_app/presentation/view/auth/login/login_view.dart';
import 'package:notes_app/presentation/view/home/layout/widget/home_card.dart';
import 'package:notes_app/presentation/view/home/layout/widget/search_bar.dart';
import 'package:notes_app/presentation/view/no_data/list_is_empty.dart';


class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}
bool _isLoading = false;
class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    bool aa = true;
    return LoadingOverlay(
      isLoading: _isLoading,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                image: const DecorationImage(image: AssetImage('assets/images/top.png') , fit: BoxFit.fill)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0,horizontal: 8),
                child: Row(
                  children: [
                    Flexible(
                      child: SearchBar(hint: 'Search', iconData: Icons.search,),
                      fit: FlexFit.tight,
                    ),
                    SizedBox(width: 20,),
                    InkWell(
                      onTap: (){
                        showNavigationDialog(context, title: "Logout", buttonText: 'Yes', message: 'Do you want to Logout? ', secondButton: "No", navigation: (){
                          _signOut();
                        }, isSecondButton: true);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: FrontEndConfig.kButtonColor,
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: Icon(Icons.logout , color: Colors.white,),
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            aa? Container(height: 106, width: MediaQuery.of(context).size.width, color: FrontEndConfig.kButtonColor,): SizedBox(),
            HomeCard(),
          ],
        ),
      ),
    );
  }
  void _signOut() async
  {
    _isLoadingTrue();
    try{
      await FirebaseAuth.instance.signOut().whenComplete(() {
        _isLoadingFalse();
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            LoginView()), (Route<dynamic> route) => false);
      });
    }
    catch(e)
    {
      Fluttertoast.showToast(msg: e.toString());
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
