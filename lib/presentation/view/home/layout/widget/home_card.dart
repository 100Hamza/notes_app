import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/config/front_end_config.dart';
import 'package:notes_app/presentation/elements/custom_text.dart';

import '../../../no_data/list_is_empty.dart';

class HomeCard extends StatefulWidget {
  const HomeCard({super.key});
  @override
  State<HomeCard> createState() => _HomeCardState();
}

List<DocumentSnapshot> allData = [];

class _HomeCardState extends State<HomeCard> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return allData.isEmpty? NoDataFound() : Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0 , left: 20),
          child: Container(
            alignment: Alignment.centerLeft,
              height: 20,
              width: MediaQuery.of(context).size.width,
              child: CustomText(text: 'Personal', textColor: FrontEndConfig.kCategoryTextColor, fontSize: 13, fontWeight: FontWeight.w600,)),
        ),
        Container(
          height: MediaQuery.of(context).size.height/1.9,
          child: ListView.builder(
            itemCount: allData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 10),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(width: 10 , decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.horizontal(left: Radius.circular(10))),),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(text: '09' , textColor: FrontEndConfig.kOnBoardingSecondTextColor),
                                  CustomText(text: 'June' , textColor: FrontEndConfig.kOnBoardingSecondTextColor,),
                                ],),
                              CustomText(text: allData[index]['title'], fontSize: 14,textColor: FrontEndConfig.kButtonColor,fontWeight: FontWeight.w800),
                            ],
                          ),
                        ),
                        SizedBox(width: 50,),
                        Container(
                          width: 100 ,alignment: Alignment.centerRight, child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.favorite ,color: FrontEndConfig.kFavouriteIconColor,),
                        ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },),
        ),
      ],
    );
  }

  fetchData() async{
    var id = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('Notes').where('uId', isEqualTo: id)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
          allData.clear();
          snapshot.docs.forEach((element) {
            allData.add(element);
            setState(() {
            });
          });
    });
  }
}
