import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/config/front_end_config.dart';

class GroupCardsModel
{
  Icon? cardIcon;
  Color? color;
  String? cardName;
  GroupCardsModel({required this.cardIcon,  required this.cardName , this.color});
}

class CardList{
  List<GroupCardsModel> cardsIcon = [
  GroupCardsModel(cardIcon: Icon(Icons.person , color: Color(0xFFFFD800), size: 50), cardName: "Personal" ,color: FrontEndConfig.kPersonalCardIconBGColor),
  GroupCardsModel(cardIcon:  Icon(Icons.work_history_outlined , color: Color(0xFF36D830), size: 50,), cardName: "Work" , color: FrontEndConfig.kWorkCardIconBGColor),
  GroupCardsModel(cardIcon: Icon(Icons.meeting_room , color: Color(0xFFFF0034) , size: 50,), cardName: "Meeting" , color: FrontEndConfig.kShoppingCardIconBGColor),
  GroupCardsModel(cardIcon: Icon(Icons.shopping_bag_outlined , color: Color(0xFF36D830), size: 50,), cardName: "Shopping" , color: FrontEndConfig.kWorkCardIconBGColor),
];
}