import 'package:fgd_flutter/screens/follow_account/follow_account_screen.dart';
import 'package:fgd_flutter/screens/thread_detail/thread_detail_screen.dart';
import 'package:fgd_flutter/shared/app_colors.dart';
import 'package:fgd_flutter/shared/styles.dart';
import 'package:flutter/material.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  bool actionLike = true;
  bool actionConfirm = true;
  bool actionFollow = true;
  final primaryColor = AppColors.kcPrimaryColor;
  final whiteColor = AppColors.kcBaseWhite;

  int countBoolList(List<bool> _topicStatus) {
    int count = 0;
    for (int i = 0; i < _topicStatus.length; i++) {
      if (_topicStatus.elementAt(i) == true) {
        count++;
      }
    }
    return count;
  }

  List<bool> _topicStatus = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 12.5, bottom: 12.5),
              child: Text(
                'Bookmark',
                style: heading3Bold.copyWith(color: AppColors.kcPrimaryColor),
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.kcDarkWhite,
                      hintText: "Search bookmark",
                      prefixIcon: Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 20, right: 10),
                        child: Image.asset(
                          height: 24,
                          width: 24,
                          'assets/icon_search_normal.png',
                        ),
                      ),
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _topicStatus[0] = !_topicStatus[0];
                    });
                    buildFilterSearch();
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 8, right: 8),
                    child: Image.asset(
                      height: 24,
                      width: 24,
                      'assets/icon_filter_search.png',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPostThread(),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ThreadDetailScreen()));
                },
                child: _buildPostThreadWithImage()),
            _buildPostThread(),
            _buildPostThreadWithImage(),
          ],
        ),
      ),
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
            _buildProfileThreadFake(),
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

  ListTile _buildProfileThreadFake() {
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

  // Postingan Thread yang ada fotonya

  Container _buildPostThreadWithImage() {
    return Container(
      color: Color(0xffeeeeee),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              _buildProfileReal(),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.only(left: 16, right: 270),
                decoration: BoxDecoration(
                  color: Color(0xffececec),
                  borderRadius: BorderRadius.circular(50),
                ),
                padding:
                    EdgeInsets.only(top: 5, bottom: 5, left: 12, right: 12),
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
      ),
    );
  }

  ListTile _buildProfileReal() {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => FollowAccountScreen()));
            },
            child: Text(
              'Evan Chris',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffC7C7C7),
            ),
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
      trailing: Image.asset(
        'assets/icon_more.png',
        height: 24,
        width: 24,
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
              Image.asset('assets/icon_like1.png', height: 24, width: 24),
              Text('592'),
              SizedBox(
                width: 10,
              ),
              Image.asset('assets/icon_comment.png', height: 24, width: 24),
              Text('108'),
            ],
          )
        ],
      ),
    );
  }

  ElevatedButton ChipButton(name, iter) {
    return ElevatedButton(
      child: Text(
        '$name',
        style: TextStyle(
          color: _topicStatus[iter] ? Colors.white : Colors.grey,
        ),
      ),
      style: ElevatedButton.styleFrom(
        side: BorderSide(
          color: _topicStatus[iter] ? const Color(0XFF178066) : Colors.grey,
          width: 1,
        ),
        backgroundColor:
            _topicStatus[iter] ? const Color(0XFF178066) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      onPressed: () => {
        setState(() {
          _topicStatus[iter] = !_topicStatus[iter];
        })
      },
    );
  }

// Build Bottom Sheets
  void buildFilterSearch() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 600,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'All people',
                  style: body1Semi,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  ChipButton('People you follow', 1),
                  SizedBox(
                    width: 8,
                  ),
                  ChipButton('Thread you follow', 2),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'All time',
                  style: body1Semi,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  ChipButton('Earliest', 3),
                  SizedBox(
                    width: 8,
                  ),
                  ChipButton('Latest', 4),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Threads',
                  style: body1Semi,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  ChipButton('Most popular', 5),
                  SizedBox(
                    width: 8,
                  ),
                  ChipButton('Least popular', 6),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Categories',
                  style: body1Semi,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(children: [
                ChipButton('Business', 7),
                SizedBox(
                  width: 8,
                ),
                ChipButton('Technology', 8),
                SizedBox(
                  width: 8,
                ),
                ChipButton('Games', 9),
                SizedBox(
                  width: 8,
                ),
              ]),
              Row(
                children: [
                  ChipButton('Education', 10),
                  SizedBox(
                    width: 8,
                  ),
                  ChipButton('Movie', 11),
                  SizedBox(
                    width: 8,
                  ),
                  ChipButton('Travel', 12),
                  SizedBox(
                    width: 8,
                  ),
                  ChipButton('Music', 13),
                ],
              ),
              Row(
                children: [
                  ChipButton('Horror', 14),
                  SizedBox(
                    width: 8,
                  ),
                  ChipButton('Fashion', 15),
                  SizedBox(
                    width: 8,
                  ),
                  ChipButton('Animal', 16),
                  SizedBox(
                    width: 8,
                  ),
                  ChipButton('Art', 17),
                ],
              ),
              Row(
                children: [
                  ChipButton('Food', 18),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Confirm',
                    style: body2Semi,
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}
