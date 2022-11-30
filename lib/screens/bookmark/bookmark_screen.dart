import 'package:fgd_flutter/screens/follow_account/follow_account_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Bookmark',
              style: heading3Bold.copyWith(color: AppColors.kcPrimaryColor),
            ),
            Image.asset('assets/icon_search.png', height: 24, width: 24)
          ],
        ),
      ),
      body: SingleChildScrollView(
       
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPostThread(),
            _buildPostThreadWithImage(),
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
                padding:
                    EdgeInsets.only(top: 5, bottom: 5, left: 12, right: 12),
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
        padding: EdgeInsets.only(top: 10, left: 16, right: 16),
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
              )),
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
            onTap: () {},
            child: Text(
              'Follow',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
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
}
