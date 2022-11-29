import 'package:fgd_flutter/shared/app_colors.dart';
import 'package:fgd_flutter/shared/styles.dart';
import 'package:flutter/material.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
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
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xfffdfdfd),
                border: Border.all(color: Color(0xffC7C7C7)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('assets/account_default.png',
                      width: 64, height: 72),
                  Text('Edit photo'),
                  SizedBox(
                    width: 181,
                  ),
                  GestureDetector(
                    onTap: () => editBio(),
                    child: Image.asset('assets/icon_edit_profile.png',
                        width: 24, height: 24),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xfffdfdfd),
                border: Border.all(color: Color(0xffC7C7C7)),
              ),
              child: ListTile(
                  title: Text('Edit name'),
                  subtitle: Text('Puan Maharani Sirait'),
                  trailing: GestureDetector(
                    onTap: () => editName(),
                    child: Image.asset('assets/icon_edit_profile.png',
                        width: 24, height: 24),
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xfffdfdfd),
                border: Border.all(color: Color(0xffC7C7C7)),
              ),
              child: ListTile(
                  title: Text('Edit bio'),
                  trailing: GestureDetector(
                    onTap: () => editBio(),
                    child: Image.asset('assets/icon_edit_profile.png',
                        width: 24, height: 24),
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xfffdfdfd),
                border: Border.all(color: Color(0xffC7C7C7)),
              ),
              child: ListTile(
                  title: Text('Edit password'),
                  subtitle: Text('********'),
                  trailing: GestureDetector(
                    onTap: () => editPassword(),
                    child: Image.asset('assets/icon_edit_profile.png',
                        width: 24, height: 24),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void editBio() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Container(
          alignment: Alignment.topLeft,
          height: 310,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/pony_bottom_sheet.png',
                  width: 38,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text('Edit bio', style: body1Semi),
              Text(
                'You can change your bio',
                style: TextStyle(color: Color(0xff5C5C5C)),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Description',
                style: body1Semi,
              ),
              TextFormField(
                decoration: InputDecoration(
                    fillColor: Color(0xffF1F0F5),
                    filled: true,
                    hintText: 'Write here',
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1))),
                maxLines: 4,
                keyboardType: TextInputType.multiline,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    style: ButtonStyle(alignment: Alignment.bottomRight),
                    onPressed: () {},
                    child: Text(
                      'Done',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: AppColors.kcPrimaryColor),
                    )),
              )
            ],
          ),
        );
      },
    );
  }

  void editName() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Container(
          alignment: Alignment.topLeft,
          height: 250,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/pony_bottom_sheet.png',
                  width: 38,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text('Edit Name', style: body1Semi),
              Text(
                'You can change your name up to 1 hour',
                style: TextStyle(color: Color(0xff5C5C5C)),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Name',
                style: body1Semi,
              ),
              TextFormField(
                decoration: InputDecoration(
                    fillColor: Color(0xffF1F0F5),
                    filled: true,
                    hintText: 'Tom Cruise',
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1))),
                keyboardType: TextInputType.name,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    style: ButtonStyle(alignment: Alignment.bottomRight),
                    onPressed: () {},
                    child: Text(
                      'Done',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: AppColors.kcPrimaryColor),
                    )),
              )
            ],
          ),
        );
      },
    );
  }

  void editPassword() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Container(
          alignment: Alignment.topLeft,
          height: 430,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/pony_bottom_sheet.png',
                  width: 38,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text('Edit Password', style: body1Semi),
              Text(
                'You can change your password up to 24 hour',
                style: TextStyle(color: Color(0xff5C5C5C)),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Old password',
                style: body1Semi,
              ),
              TextFormField(
                decoration: InputDecoration(
                    fillColor: Color(0xffF1F0F5),
                    filled: true,
                    hintText: 'Tom Cruise',
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1))),
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'New password',
                style: body1Semi,
              ),
              TextFormField(
                decoration: InputDecoration(
                    fillColor: Color(0xffF1F0F5),
                    filled: true,
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1))),
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Email',
                style: body1Semi,
              ),
              TextFormField(
                decoration: InputDecoration(
                    fillColor: Color(0xffF1F0F5),
                    filled: true,
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1))),
                keyboardType: TextInputType.name,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    style: ButtonStyle(alignment: Alignment.bottomRight),
                    onPressed: () {},
                    child: Text(
                      'Done',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: AppColors.kcPrimaryColor),
                    )),
              )
            ],
          ),
        );
      },
    );
  }
}
