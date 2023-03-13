import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupCardsModel
{
  Icon? cardIcon;
  String? cardName;
  GroupCardsModel({required this.cardIcon,  required this.cardName});
}
List<GroupCardsModel> cardsIcon = [
  GroupCardsModel(cardIcon: Icon(Icons.person , color: Colors.yellow,), cardName: "Personel"),
  GroupCardsModel(cardIcon:  Icon(Icons.work , color: Colors.green,), cardName: "Work"),
  GroupCardsModel(cardIcon: Icon(Icons.meeting_room , color: Colors.red), cardName: "Meeting"),
  GroupCardsModel(cardIcon: Icon(Icons.shopping_bag_outlined , color: Colors.green,), cardName: "Shopping"),
];