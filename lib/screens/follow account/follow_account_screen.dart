import 'package:fgd_flutter/shared/charum_ui.dart';
import 'package:fgd_flutter/shared/styles.dart';
import 'package:flutter/material.dart';

class FollowAccountScreen extends StatefulWidget {
  const FollowAccountScreen({super.key});

  @override
  State<FollowAccountScreen> createState() => _FollowAccountScreenState();
}

class _FollowAccountScreenState extends State<FollowAccountScreen> {
  bool actionFollow = true;
  bool actionLike = true;
  final primaryColor = AppColors.kcPrimaryColor;
  final whiteColor = AppColors.kcBaseWhite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Evan Chris’s thread',
          style: body1Bold.copyWith(color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () => _buildMoreUser(),
            child: Image.asset(
              'assets/icon_more.png',
              height: 24,
              width: 24,
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
        elevation: 1.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 15,
            ),
            Image.asset(
              'assets/fake_profile.png',
              height: 72,
              width: 72,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Evan Chris’s thread',
              style: buttonSemi,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            buildProfile(),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    actionFollow = !actionFollow;
                  });
                },
                child: Text(
                  actionFollow ? 'Follow' : 'Following',
                  style: body2Semi,
                ),
                style: actionFollow
                    ? ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      )
                    : ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(whiteColor),
                        foregroundColor:
                            MaterialStateProperty.all(primaryColor),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xff178066)),
                            borderRadius: BorderRadius.circular(50),
                          ),
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

  Row buildProfile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              '2',
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
            Text(
              '110',
              style: buttonSemi,
            ),
            Text('Following'),
          ],
        ),
        SizedBox(
          width: 50,
        ),
        Column(
          children: [
            Text(
              '983',
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
            _buildThreadWithImage(),
          ],
        ),
      ),
    );
  }

  ListTile _buildProfileThread() {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Evan Chris'),
          SizedBox(
            width: 5,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: CircleAvatar(
              backgroundColor: Color(0xffC7C7C7),
            ),
            color: Color(0xffC7C7C7),
            width: 6,
            height: 6,
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                  actionFollow = !actionFollow;
                });
              },
              child: actionFollow
                  ? Text(
                      'Follow',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      'Following',
                      style: TextStyle(
                          color: AppColors.kcLightestBlack,
                          fontWeight: FontWeight.bold),
                    )),
        ],
      ),
      subtitle: Text('1h ago'),
      leading: Image.asset('assets/fake_profile.png'),
      trailing: GestureDetector(
        onTap: () => _buildMoreThread(),
        child: Image.asset(
          'assets/icon_more.png',
          height: 24,
          width: 24,
        ),
      ),
    );
  }

  Container _buildThreadWithImage() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What’s a curious fact about building walls?',
            style: body1Bold,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset('assets/fake_thread.png'),
          ),
          Text(
              'The "wavy" brick fences. Curious as it may seem, this shape uses fewer bricks than a straight fence. That\'s because a straight fence that is just one brick thick is not sturdy enou..'),
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

  void _buildMoreThread() {
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
          height: 220,
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
              Row(children: [
                Image.asset('assets/icon_follow_bottom_sheet.png',
                    height: 24, width: 24),
                SizedBox(
                  width: 10,
                ),
                Text('Follow thread', style: body1Semi),
              ]),
              Divider(
                height: 10,
                color: Color(0xffDFDFDF),
              ),
              Row(children: [
                Image.asset('assets/icon_add_bookmark_bottom_sheet.png',
                    height: 24, width: 24),
                SizedBox(
                  width: 10,
                ),
                Text('Bookmark', style: body1Semi),
              ]),
              Divider(
                height: 10,
                color: Color(0xffDFDFDF),
              ),
              Row(children: [
                Image.asset('assets/icon_share_bottom_sheet.png',
                    height: 24, width: 24),
                SizedBox(
                  width: 10,
                ),
                Text('Share', style: body1Semi),
              ]),
              Divider(
                height: 10,
                color: Color(0xffDFDFDF),
              ),
              Row(children: [
                Image.asset('assets/icon_report_bottom_sheet.png',
                    height: 24, width: 24),
                SizedBox(
                  width: 10,
                ),
                Text('Report thread', style: body1Semi),
              ]),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }

  void _buildMoreUser() {
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
          height: 180,
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
              Row(children: [
                Image.asset('assets/icon_follow_bottom_sheet.png',
                    height: 24, width: 24),
                SizedBox(
                  width: 10,
                ),
                Text('Follow user', style: body1Semi),
              ]),
              Divider(
                height: 10,
                color: Color(0xffDFDFDF),
              ),
              Row(children: [
                Image.asset('assets/icon_share_bottom_sheet.png',
                    height: 24, width: 24),
                SizedBox(
                  width: 10,
                ),
                Text('Share', style: body1Semi),
              ]),
              Divider(
                height: 10,
                color: Color(0xffDFDFDF),
              ),
              Row(children: [
                Image.asset('assets/icon_report_bottom_sheet.png',
                    height: 24, width: 24),
                SizedBox(
                  width: 10,
                ),
                Text('Report account', style: body1Semi),
              ]),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }
}
