import 'package:fgd_flutter/shared/app_colors.dart';
import 'package:fgd_flutter/shared/styles.dart';
import 'package:flutter/material.dart';

class ThreadDetailScreen extends StatefulWidget {
  const ThreadDetailScreen({super.key});

  @override
  State<ThreadDetailScreen> createState() => _ThreadDetailScreenState();
}

class _ThreadDetailScreenState extends State<ThreadDetailScreen> {
  bool actionFollowAccount = true;
  bool actionLike = true;
  bool actionFollowThread = true;
  bool actionBookmark = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                actionBookmark = !actionBookmark;
              });
              _buildSnackBarActionBookmark();
            },
            child: actionBookmark
                ? Image.asset(
                    'assets/icon_add_bookmark_bottom_sheet.png',
                    height: 24,
                    width: 24,
                  )
                : Image.asset(
                    'assets/icon_remove_bookmark.png',
                    height: 24,
                    width: 24,
                  ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () => _buildMoreThread(),
            child: Image.asset(
              'assets/icon_more.png',
              height: 24,
              width: 24,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Container(
        color: Color(0xfff1f3f5),
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16, right: 300),
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
                _buildProfileThread(),
                Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      'How do you increase the visibility of your business?',
                      style: heading3Bold,
                    )),
                _buildThreadWithImage(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
          decoration:
              BoxDecoration(border: Border.all(color: Color(0xffe3e3e3))),
          padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
          height: 48,
          width: 360,
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  style:
                                      TextStyle(color: AppColors.kcInfoColor),
                                ),
                              ],
                            )),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Image.asset('assets/icon_comment.png',
                          height: 24, width: 24),
                      Text('108'),
                    ],
                  ),
                ],
              ),
              Container(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () {
                        _buildSnackBarActionThread();
                        setState(() {
                          actionFollowThread = !actionFollowThread;
                        });
                      },
                      child: actionFollowThread
                          ? Text(
                              'Follow thread',
                              style: TextStyle(
                                  color: AppColors.kcPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              'Following Thread',
                              style: TextStyle(
                                  color: AppColors.kcLightestBlack,
                                  fontWeight: FontWeight.bold),
                            )),
                ),
              )
            ],
          )),
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
                  actionFollowAccount = !actionFollowAccount;
                });
              },
              child: actionFollowAccount
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
    );
  }

  Container _buildThreadWithImage() {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset('assets/fake_thread.png'),
          ),
          Text(
              'There are a number of ways to increase the visibility of your business. One of the most effective is to invest in search engine optimization (SEO). This involves optimizing your website and content so that it ranks higher in search engine results pages. Another great way to get your business seen by more people is through paid advertising. You can use platforms like Google AdWords or Facebook Ads to target specific audiences with your message. Finally, you can also promote your business through PR and marketing efforts. This includes getting featured in publications, online and offline, as well as reaching out to influencers in your industry.'),
          Text(
              'There are a number of ways to increase the visibility of your business. One of the most effective is to invest in search engine optimization (SEO). This involves optimizing your website and content so that it ranks higher in search engine results pages. Another great way to get your business seen by more people is through paid advertising. You can use platforms like Google AdWords or Facebook Ads to target specific audiences with your message. Finally, you can also promote your business through PR and marketing efforts. This includes getting featured in publications, online and offline, as well as reaching out to influencers in your industry.'),
          Text(
              'There are a number of ways to increase the visibility of your business. One of the most effective is to invest in search engine optimization (SEO). This involves optimizing your website and content so that it ranks higher in search engine results pages. Another great way to get your business seen by more people is through paid advertising. You can use platforms like Google AdWords or Facebook Ads to target specific audiences with your message. Finally, you can also promote your business through PR and marketing efforts. This includes getting featured in publications, online and offline, as well as reaching out to influencers in your industry.'),
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
          height: 160,
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
                Image.asset('assets/icon_share_bottom_sheet.png',
                    height: 24, width: 24),
                SizedBox(
                  width: 10,
                ),
                Text('Share', style: body1Semi),
              ]),
              Divider(
                height: 20,
                color: Color(0xffDFDFDF),
              ),
              Row(children: [
                Image.asset('assets/icon_report_bottom_sheet.png',
                    height: 24, width: 24),
                SizedBox(
                  width: 10,
                ),
                Text('Report', style: body1Semi),
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

  void _buildSnackBarActionBookmark() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 500),
        backgroundColor:
            actionBookmark ? Color(0xfff91516) : AppColors.kcPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 130,
            right: 20,
            left: 20),
        behavior: SnackBarBehavior.floating,
        content: actionBookmark
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icon_succes_remove_bookmark_circle.png',
                    height: 22,
                    width: 22,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Thread removed to your Bookmarks',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icon_succes_add_bookmark_circle.png',
                    height: 24,
                    width: 24,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Thread added to your Bookmarks',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
      ),
    );
  }

  void _buildSnackBarActionThread() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 500),
        backgroundColor:
            actionFollowThread ? AppColors.kcPrimaryColor : Color(0xfff91516),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 130,
            right: 20,
            left: 20),
        behavior: SnackBarBehavior.floating,
        content: actionFollowThread
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icon_succes_add_bookmark_circle.png',
                    height: 24,
                    width: 24,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Thread successfully followed',
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icon_succes_remove_bookmark_circle.png',
                    height: 22,
                    width: 22,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Thread successfully unfollowed',
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
      ),
    );
  }
}
