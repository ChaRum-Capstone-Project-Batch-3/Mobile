import 'package:fgd_flutter/models/thread_detail/thread_response.dart';
import 'package:fgd_flutter/providers/get_alltopics_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../shared/app_colors.dart';
import '../../shared/charum_ui.dart';

class DetailSpace extends StatefulWidget {
  const DetailSpace({super.key, required this.topicId});
  final String topicId;

  @override
  State<DetailSpace> createState() => _DetailSpaceState();
}

class _DetailSpaceState extends State<DetailSpace> {
  @override
  void initState() {
    Provider.of<AllTopicsViewModel>(context, listen: false)
        .topicDetail(widget.topicId);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AllTopicsViewModel>(
        builder: (context, value, child) => DefaultTabController(
              length: 2,
              child: Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 100,
                    iconTheme: IconThemeData(color: Colors.black),
                    elevation: 0,
                    backgroundColor: Colors.white,
                    actions: [
                      InkWell(
                        onTap: () {},
                        child: Image.asset(
                          "assets/search-normal.png",
                        ),
                      ),
                    ],
                    bottom: PreferredSize(
                      preferredSize: const Size(100, 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  value.topic.topic ?? "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(height: 5),
                                Text(
                                    value.topic.description ?? ""),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                          TabBar(
                            indicator: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              color: AppColors.kcPrimaryColor!.shade200,
                            ),
                            indicatorColor: AppColors.kcPrimaryColor,
                            isScrollable: true,
                            labelColor: AppColors.kcPrimaryColor,
                            unselectedLabelColor: AppColors.kcDarkestWhite,
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: [
                              Tab(
                                child: Row(
                                  children: [
                                    Image.asset("assets/threads.png"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Threads",
                                      style: subtitle2Semi,
                                    ),
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  children: [
                                    Image.asset("assets/star.png"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Popular",
                                      style: subtitle2Semi,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  body: TabBarView(children: [
                    SingleChildScrollView(
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
                    SingleChildScrollView(
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
                  ])),
            ));
  }


 Container _buildPostThread(int index) {
    var provider = Provider.of<BookmarkViewModel>(context, listen: false);
    var bookmark = provider.bookmarks[index];
    return Container(
      color: Color(0xffeeeeee),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
      child: Container(
        padding: spacing16All,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileThreadFake(bookmark.thread!),
            Container(
              margin: spacing16Top,
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 12, right: 12),
              decoration: BoxDecoration(
                color: AppColors.kcDarkerWhite,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: BoxText.caption(
                bookmark.thread!.topic!.topic! ?? "",
                color: AppColors.kcLighterBlack,
              ),
            ),
            _buildThread(index),
          ],
        ),
      ),
    );
  }

  Row _buildProfileThreadFake(Threads thread) {
    final date = DateTime.parse(thread.createdAt!).toLocal();
    final now = DateTime.now();
    final diff = between(date, now);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.kcPrimaryColor,
              ),
              Container(
                margin: spacing8Left,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        BoxText.captionSemi(thread.creator!.displayName!),
                        Container(
                          margin: spacing8Horizontal,
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.kcDarkestWhite,
                            shape: BoxShape.circle,
                          ),
                        ),
                        thread.isFollowed!
                            ? GestureDetector(
                                child: Text(
                                  "Followed",
                                  style: captionSemi.copyWith(
                                    color: AppColors.kcLightestBlack,
                                  ),
                                ),
                              )
                            : GestureDetector(
                                child: Text(
                                  "Follow",
                                  style: captionSemi.copyWith(
                                    color: AppColors.kcInfoColor,
                                  ),
                                ),
                              )
                      ],
                    ),
                    BoxText.body3(
                      diff.toString(),
                      color: AppColors.kcLightestBlack,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          child: GestureDetector(
            child: ImageIcon(AssetImage('assets/icon_more.png')),
            onTap: () {
              other(thread);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildThread(int index) {
    var provider = Provider.of<BookmarkViewModel>(context, listen: false);
    var thread = provider.bookmarks[index].thread;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 4,
          ),
          BoxText.subtitle2Semi(thread!.title!),
          Container(
            margin: spacing8Top,
            child: BoxText.caption(thread.description!),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                child: thread.isLiked!
                    ? GestureDetector(
                        onTap: () {
                          provider.unlikeThread(index);
                          // provider.getBookmark();
                        },
                        child: Row(children: [
                          ImageIcon(
                            AssetImage('assets/icon_like2.png'),
                            color: AppColors.kcInfoColor,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          BoxText.captionSemi(
                            thread.totalLike.toString(),
                            color: AppColors.kcInfoColor,
                          )
                        ]),
                      )
                    : GestureDetector(
                        onTap: () {
                          provider.likeThread(index);
                          // provider.getBookmark();
                        },
                        child: Row(children: [
                          ImageIcon(
                            AssetImage('assets/icon_like1.png'),
                            color: AppColors.kcLightestBlack,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          BoxText.captionSemi(
                            thread.totalLike.toString(),
                            color: AppColors.kcLightestBlack,
                          )
                        ]),
                      ),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                child: GestureDetector(
                  child: Row(
                    children: [
                      ImageIcon(
                        AssetImage('assets/icon_comment.png'),
                        color: AppColors.kcLightestBlack,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      BoxText.captionSemi(
                        thread.totalComment.toString(),
                        color: AppColors.kcLightestBlack,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
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

  void other(Threads thread) {
    var provider = Provider.of<BookmarkViewModel>(context, listen: false);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        backgroundColor: AppColors.kcBaseWhite,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            padding: spacing20All,
            child: Column(
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
                Container(
                  child: thread.isFollowed!
                      ? InkWell(
                          onTap: () {
                            provider.unfollowThread(thread.sId!);
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              ImageIcon(
                                  AssetImage('assets/unfollow-thread.png')),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Unfollow Thread",
                                style: button,
                              ),
                            ],
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            provider.followThread(thread.sId!);
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              ImageIcon(
                                  AssetImage('assets/icon_follow_thread.png')),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Follow Thread",
                                style: button,
                              ),
                            ],
                          ),
                        ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: thread.isBookmarked!
                      ? InkWell(
                          onTap: () {
                            provider.unbookmarkThread(thread.sId!);
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              ImageIcon(AssetImage(
                                  'assets/icon_remove_bookmark.png')),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Remove Bookmark",
                                style: button,
                              ),
                            ],
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            provider.bookmarkThread(thread.sId!);
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              ImageIcon(
                                  AssetImage('assets/icon_bookmark1.png')),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Bookmark",
                                style: button,
                              ),
                            ],
                          ),
                        ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: Row(
                    children: [
                      ImageIcon(
                          AssetImage('assets/icon_share_bottom_sheet.png')),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Share",
                        style: button,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: Row(
                    children: [
                      ImageIcon(
                          AssetImage('assets/icon_report_bottom_sheet.png')),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Report Thread",
                        style: button,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
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

  Widget loadingThread() {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: spacing16All,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: spacing8Bottom,
                  padding: spacing16All,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: AppColors.kcBaseWhite,
                  ),
                  child: Shimmer.fromColors(
                    baseColor: AppColors.kcDarkestWhite,
                    highlightColor: AppColors.kcDarkWhite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppColors.kcPrimaryColor,
                                  ),
                                  Container(
                                    margin: spacing8Left,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                color: AppColors.kcDarkestWhite,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: spacing8Horizontal,
                                              width: 4,
                                              height: 4,
                                              decoration: BoxDecoration(
                                                color: AppColors.kcDarkestWhite,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Container(
                                              width: 50,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                color: AppColors.kcDarkestWhite,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: 50,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: AppColors.kcDarkestWhite,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: GestureDetector(
                                child: ImageIcon(
                                    AssetImage('assets/icon_more.png')),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: spacing16Top,
                          padding: EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                            left: 12,
                            right: 12,
                          ),
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColors.kcDarkerWhite,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          width: 200,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColors.kcDarkestWhite,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColors.kcDarkestWhite,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColors.kcDarkestWhite,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColors.kcDarkestWhite,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 10,
                              decoration: BoxDecoration(
                                color: AppColors.kcDarkestWhite,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              width: 50,
                              height: 10,
                              decoration: BoxDecoration(
                                color: AppColors.kcDarkestWhite,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  String between(DateTime from, DateTime to) {
    String diff = "";
    from = DateTime(
        from.year, from.month, from.day, from.hour, from.minute, from.second);
    to = DateTime(to.year, to.month, to.day, to.hour, to.minute, to.second);
    if (to.difference(from).inDays > 0 && to.difference(from).inDays <= 3) {
      diff = to.difference(from).inDays.toString() + "d ago";
    } else if (to.difference(from).inHours > 0 &&
        to.difference(from).inHours <= 60) {
      diff = to.difference(from).inHours.toString() + "h ago";
    } else if (to.difference(from).inMinutes > 0 &&
        to.difference(from).inMinutes <= 60) {
      diff = to.difference(from).inMinutes.toString() + "m ago";
    } else if (to.difference(from).inSeconds > 0 &&
        to.difference(from).inSeconds <= 60) {
      diff = to.difference(from).inSeconds.toString() + "s ago";
    } else {
      diff = DateFormat('MMMM d, yyyy').format(from);
    }
    return diff;
  }
}