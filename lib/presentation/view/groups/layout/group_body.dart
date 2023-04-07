import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:notes_app/navigation_helper/navigation_helper.dart';
import 'package:notes_app/presentation/view/groups/layout/model.dart';
import 'package:notes_app/presentation/view/home/layout/home_body.dart';

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
CardList list = CardList();
List<DocumentSnapshot> countList = [];
List<int> categoryCount = [ 0 , 0 , 0 , 0];

class _GroupBodyState extends State<GroupBody> {
  List<GroupCardsModel> cardModel = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countNotes();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoadingOverlay(
        isLoading: _isLoading,
        child: Column(
          children: [
            Container(
              height: 100,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/top.png'),
                      fit: BoxFit.fill)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8),
                child: Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: SearchBar(
                        hint: 'Search',
                        iconData: Icons.search,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        showNavigationDialog(context,
                            title: "Logout",
                            buttonText: 'Yes',
                            message: 'Do you want to Logout? ',
                            secondButton: "No", navigation: () {
                          _signOut();
                        }, isSecondButton: true);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: FrontEndConfig.kButtonColor,
                            borderRadius: BorderRadius.circular(50)),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 106,
              width: MediaQuery.of(context).size.width,
              color: FrontEndConfig.kButtonColor,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 20),
              child: Container(
                  alignment: Alignment.centerLeft,
                  height: 20,
                  width: MediaQuery.of(context).size.width,
                  child: CustomText(
                    text: 'Groups',
                    textColor: FrontEndConfig.kCategoryTextColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: GridView.builder(
                  itemCount: list.cardsIcon.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    return Material(
                      elevation: 15,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                // Navigator.of(context).pushAndRemoveUntil(
                                //     MaterialPageRoute(builder: (context) => HomeBody(groupName: list.cardsIcon[index].cardName,)),
                                //         (Route<dynamic> route) => false);
                                NavigationHelper.pushRoute(context, HomeBody(groupName: list.cardsIcon[index].cardName));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: list.cardsIcon[index].color,
                                    borderRadius: BorderRadius.circular(50)),
                                child: list.cardsIcon[index].cardIcon,
                              ),
                            ),
                            CustomText(
                              text: list.cardsIcon[index].cardName.toString(),
                              fontSize: 17.0,
                            ),
                            CustomText(
                              text: categoryCount[index].toString(),
                              textColor:
                                  FrontEndConfig.kGroupCardsNotesCountColor,
                              fontSize: 12,
                            ),
                            CustomText(
                              text: "Notes",
                              textColor:
                                  FrontEndConfig.kGroupCardsNotesCountColor,
                              fontSize: 12,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void count()
  {
    print('Count Function');
    categoryCount = [0 , 0,0,0];
    print('Count List ${countList.length}');
    for(int i=0; i<countList.length; i++)
      {
        if(countList[i]['group'] == 'Personal')
          {
            categoryCount[0]++;
            setState(() {
            });
          }
        else if(countList[i]['group'] == 'Work')
          {
            categoryCount[1]++;
            setState(() {
            });
          }
        else if(countList[i]['group'] == 'Meeting')
        {
          categoryCount[2]++;
          setState(() {
          });
        }
        else if(countList[i]['group'] == 'Shopping')
        {
          categoryCount[3]++;
          setState(() {
          });
        }
      }
    print('Count List after loop ${countList.length}');
  }
  void countNotes() async
  {
    print('Before TRY');
    try
        {
          var uID = FirebaseAuth.instance.currentUser!.uid;
          FirebaseFirestore.instance.collection('Notes').where('userId', isEqualTo: uID)
              .snapshots().listen((QuerySnapshot snapshot) {
            countList.clear();
            for (var element in snapshot.docs) {
              countList.add(element);
              setState(() {
                count();
              });
            }
          });

          print('Count List in countNotes() ${countList.length}');

        }
        catch(e)
        {
          Fluttertoast.showToast(msg: e.toString());
        }
  }

  void _signOut() async {
    _isLoadingTrue();
    try {
      await FirebaseAuth.instance.signOut().whenComplete(() {
        _isLoadingFalse();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginView()),
            (Route<dynamic> route) => false);
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'You are signing out successfully');
      _isLoadingFalse();
    }
  }

  void _isLoadingTrue() {
    setState(() {
      _isLoading = true;
    });
  }

  void _isLoadingFalse() {
    setState(() {
      _isLoading = false;
    });
  }
}
