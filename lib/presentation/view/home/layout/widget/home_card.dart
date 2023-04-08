import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:notes_app/config/front_end_config.dart';
import 'package:notes_app/presentation/elements/custom_text.dart';
import 'package:notes_app/presentation/elements/navigation_dialog.dart';
import 'package:notes_app/presentation/view/home/layout/widget/slide_widget.dart';

import '../../../no_data/list_is_empty.dart';

class HomeCard extends StatefulWidget {
  String? groupName = 'Personal';

  HomeCard({this.groupName});

  @override
  State<HomeCard> createState() => _HomeCardState();
}

List<DocumentSnapshot> allData = [];
bool _isLoading = false;

class _HomeCardState extends State<HomeCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return allData.isEmpty
        ? const NoDataFound()
        : LoadingOverlay(
      isLoading: _isLoading,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20),
                child: Container(
                    alignment: Alignment.centerLeft,
                    height: 20,
                    width: MediaQuery.of(context).size.width,
                    child: CustomText(
                      text: widget.groupName,
                      textColor: FrontEndConfig.kCategoryTextColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.9,
                child: ListView.builder(
                  itemCount: allData.length,
                  itemBuilder: (context, index) {
                    final item = allData[index].toString();
                    return Dismissible(
                      // direction: DismissDirection.startToEnd,
                      key: Key(item),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          Fluttertoast.showToast(msg: 'This is Edit Swipe');
                        } else {
                          await showNavigationDialog(context,
                              title: 'Delete',
                              buttonText: 'Yes',
                              message: 'Do you want to Delete? ',
                              secondButton: 'No', navigation: () {
                            delete(index);
                            Navigator.pop(context);
                          }, isSecondButton: true);
                        }
                        return null;
                      },
                      onDismissed: (direction) {},
                      background: SlideWidget(
                        backgroundColor: Colors.green,
                        labelText: 'Edit',
                        icon: Icons.edit,
                        mainAxisAlignment: MainAxisAlignment.start,
                        iconPadding: const EdgeInsets.only(left: 20),
                      ),
                      secondaryBackground: SlideWidget(
                          backgroundColor: Colors.red,
                          labelText: 'Delete',
                          icon: Icons.delete,
                          mainAxisAlignment: MainAxisAlignment.end,
                          iconPadding: const EdgeInsets.only(right: 20)),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Material(
                          elevation: 15,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 10,
                                        decoration: const BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.horizontal(
                                                    left:
                                                        Radius.circular(10))),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                              text: '09',
                                              textColor: FrontEndConfig
                                                  .kOnBoardingSecondTextColor),
                                          CustomText(
                                            text: 'June',
                                            textColor: FrontEndConfig
                                                .kOnBoardingSecondTextColor,
                                          ),
                                        ],
                                      ),
                                      CustomText(
                                          text: allData[index]['title'],
                                          fontSize: 14,
                                          textColor:
                                              FrontEndConfig.kButtonColor,
                                          fontWeight: FontWeight.w800),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                Container(
                                  width: 100,
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.favorite,
                                      color:
                                          FrontEndConfig.kFavouriteIconColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
  }

  fetchData() async {
    var id = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('Notes')
        .where(
          'userId',
          isEqualTo: id,
        )
        .where('group', isEqualTo: widget.groupName)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      allData.clear();
      snapshot.docs.forEach((element) {
        allData.add(element);
        setState(() {});
      });
    });
  }

  void delete (int index) async {
    _isLoadingTrue();
    try {
     await FirebaseFirestore.instance
          .collection('Notes')
          .doc(allData[index]['docId'])
          .delete()
          .then(
            (value) {
          setState(() {});
          _isLoadingFalse();
          Fluttertoast.showToast(
              msg: 'This is Delete Swipe');
          // return Navigator.of(context).pop();
        },
      );
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      _isLoadingFalse();
      // Navigator.pop(context);
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
