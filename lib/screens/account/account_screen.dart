import 'package:fgd_flutter/screens/edit_account/edit_account_screen.dart';
import 'package:fgd_flutter/shared/charum_ui.dart';
import 'package:fgd_flutter/shared/styles.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool actionLike = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Tom Cruise',
          style: buttonSemi.copyWith(color: Colors.black),
        ),
        elevation: 1.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 15,
            ),
            Image.asset(
              'assets/account_default.png',
              height: 72,
              width: 72,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Tom Cruise',
              style: buttonSemi,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            _buildProfile(),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditAccountScreen(),
                      ));
                },
                child: Text(
                  'Edit Profile',
                  style: body2Semi,
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ),
            ),
            _buildPostThread(),
            _buildPostThread(),
            _buildPostThread(),
            _buildPostThread(),
          ],
        ),
      ),
    );
  }

  Row _buildProfile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              '1',
              style: buttonSemi,
            ),
            Text('Thread'),
          ],
        ),
        SizedBox(
          width: 50,
        ),
        Column(
          children: [
            Text('500', style: buttonSemi),
            Text('Following'),
          ],
        ),
        SizedBox(
          width: 50,
        ),
        Column(
          children: [
            Text(
              '44',
              style: buttonSemi,
            ),
            Text('Followers'),
          ],
        ),
      ],
    );
  }

  Container _buildPostThread() {
    return Container(
      color: Color(0xffeeeeee),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            _buildProfileThread(),
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 270),
              decoration: BoxDecoration(
                color: Color(0xffececec),
                borderRadius: BorderRadius.circular(50),
              ),
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 12, right: 12),
              child: Text(
                'Education',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            _buildThread(),
          ],
        ),
      ),
    );
  }

  ListTile _buildProfileThread() {
    return ListTile(
      title: Text('Tom Cruise'),
      subtitle: Text('1h ago'),
      leading: Image.asset('assets/account_default.png'),
      trailing: Image.asset(
        'assets/icon_more.png',
        height: 24,
        width: 24,
      ),
    );
  }

  Container _buildThread() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Is it grammatically correct to say, “I am going to go”?',
            style: body1Bold,
          ),
          Text(
              'It is technically correct but it is ambiguous. The infinitive ‘to go\' is hanging. It may be clear from the context but not as written. Consider, does it mean ‘go now\' or ‘go to the event\''),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      actionLike = !actionLike;
                    });
                  },
                  child: actionLike
                      ? Row(
                          children: [
                            Image.asset('assets/icon_like1.png',
                                height: 24, width: 24),
                            Text('592'),
                          ],
                        )
                      : Row(
                          children: [
                            Image.asset('assets/icon_like2.png',
                                height: 24, width: 24),
                            Text(
                              '592',
                              style: TextStyle(color: AppColors.kcInfoColor),
                            ),
                          ],
                        )),
              SizedBox(
                width: 10,
              ),
              Row(
                children: [
                  Image.asset('assets/icon_comment.png', height: 24, width: 24),
                  Text('108'),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
