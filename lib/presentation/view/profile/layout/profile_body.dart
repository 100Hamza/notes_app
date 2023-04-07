import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app/config/front_end_config.dart';
import 'package:notes_app/presentation/elements/custom_textf_field.dart';
import 'package:notes_app/presentation/view/profile/layout/widgets/image_source_dialog.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

TextEditingController _nameController = TextEditingController();
TextEditingController _phoneController = TextEditingController();
TextEditingController _ageController = TextEditingController();

class _ProfileBodyState extends State<ProfileBody> {
  XFile? _imageFile;

  Future getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    setState(() {
      if (pickedImage != null) {
        _imageFile = XFile(pickedImage.path);
      } else {
        print('No Image selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              showImageSourceDialog(context, onCameraPress: () {
                getImage(ImageSource.camera);
                Navigator.pop(context);
              }, onGalleryPress: () {
                getImage(ImageSource.gallery);
                Navigator.pop(context);
              });
            },
            child: _imageFile != null
                ? CircleAvatar(
                    radius: 50,
                    backgroundImage: _imageFile == null
                        ? null
                        : FileImage(File(_imageFile!.path)),
                  )
                : CircleAvatar(
                    radius: 50,
                    backgroundColor: FrontEndConfig.kButtonColor,
                    child: Icon(
                      Icons.person,
                      size: 80,
                    )),
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            textInputType: TextInputType.name,
            controller: _nameController,
            hint: 'Full Name',
            iconData: Icons.person,
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            textInputType: TextInputType.phone,
            controller: _phoneController,
            hint: 'Phone#',
            iconData: Icons.phone,
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            textInputType: TextInputType.number,
            controller: _ageController,
            hint: 'Age',
            iconData: Icons.height,
          )
        ],
      ),
    );
  }
}
