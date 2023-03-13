import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:notes_app/config/front_end_config.dart';
import 'package:notes_app/navigation_helper/navigation_helper.dart';
import 'package:notes_app/presentation/elements/custom_text.dart';
import 'package:notes_app/presentation/elements/custom_textf_field.dart';
import 'package:notes_app/presentation/view/home/home_view.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}
TextEditingController _titleController = TextEditingController();
TextEditingController _descriptionController = TextEditingController();
bool _isLoading = false;
class _NotesViewState extends State<NotesView> {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          NavigationHelper.pushRoute(context, HomeView());
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    InkWell(
                      onTap: (){
                        _addNotes();
                      },
                      child: const Icon(
                        Icons.arrow_circle_up_sharp,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(controller: _titleController,hint: 'Title', isIcons: false,fontWeight: FontWeight.bold, fontSize: 22.0, fontColor: FrontEndConfig.kNoteTitle,isBorder: false),
                    CustomText(text: DateTime.now().toString() , textColor: FrontEndConfig.kNotesTime,),
                    CustomTextField(controller: _descriptionController, hint: 'Type Something.....', isIcons: false,fontWeight: FontWeight.bold, fontSize: 16.0, fontColor: FrontEndConfig.kNoteTitle,isBorder: false , maxLines: 10),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void _addNotes() async
  {
    try{
      _isLoadingTrue();
      var id = FirebaseAuth.instance.currentUser!.uid;
      var docID = FirebaseFirestore.instance.collection('Notes').doc().id;
      await FirebaseFirestore.instance.collection('Notes').doc(docID).set({
        "title": _titleController.text,
        "description": _descriptionController.text,
        "date&Time": DateTime.now(),
        "userId": id,
        "docId": docID,
      }).whenComplete(() {
        _isLoadingFalse();
        NavigationHelper.pushRoute(context, HomeView());
      });
    }
    catch(e)
    {
      Fluttertoast.showToast(msg: "Error: $e");
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
