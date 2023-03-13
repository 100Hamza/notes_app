import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/presentation/view/groups/layout/model.dart';

import '../../../../config/front_end_config.dart';
import '../../../elements/custom_text.dart';
import '../../../elements/navigation_dialog.dart';
import '../../auth/login/login_view.dart';
import '../../home/layout/widget/search_bar.dart';

class GroupBody extends StatefulWidget {
  const GroupBody({Key? key}) : super(key: key);

  @override
  State<GroupBody> createState() => _GroupBodyState();
}
bool _isLoading = false;
class _GroupBodyState extends State<GroupBody> {
  List<GroupCardsModel> cardModel = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          Container(height: 106, width: MediaQuery.of(context).size.width, color: FrontEndConfig.kButtonColor,),
          Padding(
            padding: const EdgeInsets.only(top: 10.0 , left: 20),
            child: Container(
                alignment: Alignment.centerLeft,
                height: 20,
                width: MediaQuery.of(context).size.width,
                child: CustomText(text: 'Groups', textColor: FrontEndConfig.kCategoryTextColor, fontSize: 13, fontWeight: FontWeight.w600,)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 10),
              child: GridView.builder(
                itemCount: cardModel.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20
                ),
                itemBuilder: (context, index){
                return Material(
                  elevation: 15,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Container(
                          child: cardModel[index].cardIcon,
                        )

                      ],
                    ),
                  ),
                );
              },),
            ),
          )
        ],
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
      Fluttertoast.showToast(msg: 'You are signing out successfully');
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
