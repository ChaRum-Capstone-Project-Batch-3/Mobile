import 'dart:io';

import 'package:fgd_flutter/providers/get_user_view_model.dart';
import 'package:fgd_flutter/providers/update_user_view_model.dart';
import 'package:fgd_flutter/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../models/account/update_user_model.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final colorTitle = AppColors.kcLightBlack;
  final ImagePicker _picker = ImagePicker();
  File? image;

  TextEditingController teUsername = TextEditingController();
  TextEditingController teName = TextEditingController();
  TextEditingController teBio = TextEditingController();
  TextEditingController teSosial = TextEditingController();

  @override
  void initState() {
    var providerUser = Provider.of<GetUserViewModel>(context, listen: false);
    providerUser.getUsers();
    teUsername.text = providerUser.user.userName ?? '';
    teName.text = providerUser.user.displayName ?? '';
    teBio.text = providerUser.user.biodata ?? '';
    teSosial.text = providerUser.user.socialMedia ?? '';
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    teUsername.dispose();
    teName.dispose();
    teBio.dispose();
    teSosial.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
        ),
        elevation: 1.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Edit Profile',
              style: TextStyle(color: Colors.black),
            ),
            Container(
              padding: EdgeInsets.all(14.5),
              child: Consumer<UpdateUserViewModel>(
                builder: (context, provider, child) {
                  return InkWell(
                    onTap: () async {
                      var providerGet =
                          Provider.of<GetUserViewModel>(context, listen: false);

                      UpdateUserModel user = UpdateUserModel(
                          email: providerGet.user.email,
                          profilePictureURL: image != null ? image!.path : "",
                          userName: teUsername.text,
                          displayName: teName.text,
                          biodata: teBio.text,
                          socialMedia: teSosial.text);
                      var result = provider.updateUsers(user);
                      await result.whenComplete(() async {
                        await result.then((value) {
                          if (value) {
                            Provider.of<GetUserViewModel>(context,
                                    listen: false)
                                .getThreads();
                            Provider.of<GetUserViewModel>(context,
                                    listen: false)
                                .getUsers();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Update Profile Success'),
                              ),
                            );
                          }
                        });
                      });
                    },
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kcPrimaryColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: Consumer<GetUserViewModel>(
                  builder: (context, provider, child) {
                    return Stack(
                      children: [
                        image != null
                            ? Container(
                                width: 100,
                                height: 100,
                                child: CircleAvatar(
                                  backgroundImage: FileImage(
                                    image!,
                                  ),
                                ),
                              )
                            : Container(
                                height: 100,
                                width: 100,
                                child: provider.user.profilePictureURL != null
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(provider
                                            .user.profilePictureURL
                                            .toString()),
                                      )
                                    : CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/account_default.png'),
                                      ),
                              ),
                        Positioned.fill(
                            child: Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              getImage();
                            },
                            child: Image.asset('assets/icon_edit_photo.png',
                                width: 28, height: 28),
                          ),
                        )),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Username',
                  style: TextStyle(color: colorTitle),
                ),
              ),
              TextField(
                obscureText: false,
                controller: teUsername,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Name',
                  style: TextStyle(color: colorTitle),
                ),
              ),
              TextField(
                obscureText: false,
                controller: teName,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Bio',
                  style: TextStyle(color: colorTitle),
                ),
              ),
              TextField(
                controller: teBio,
                maxLines: 5,
                obscureText: false,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Social media',
                  style: TextStyle(color: colorTitle),
                ),
              ),
              TextField(
                controller: teSosial,
                obscureText: false,
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
  }
}
