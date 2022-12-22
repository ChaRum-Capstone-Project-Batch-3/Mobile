import 'package:fgd_flutter/models/thread/thread.dart';
import 'package:fgd_flutter/providers/get_alltopics_view_model.dart';
import 'package:fgd_flutter/screens/thread_detail/widgets/comment_screen.dart';
import 'package:fgd_flutter/shared/helper.dart';
import 'package:fgd_flutter/shared/router.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fgd_flutter/shared/charum_ui.dart';

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
    return DefaultTabController(
      length: 2,
      child: Consumer<AllTopicsViewModel>(
        builder: (context, provider, child) {
          return Scaffold(
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
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              provider.topic.topic ?? "",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(height: 5),
                            Text(provider.topic.description ?? ""),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                      TabBar(
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: ListView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: _buildPostThread(index, "thread"),
                          onTap: () {
                            Navigator.pushNamed(context, detailThread,
                                arguments: provider.threads[index].sId);
                          },
                        );
                      },
                      itemCount: provider.threads.length,
                      shrinkWrap: true,
                    ))
                  ],
                ),
                // SingleChildScrollView(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.stretch,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       // _buildPostThread(),
                //       // _buildPostThreadWithImage(),
                //       // _buildPostThread(),
                //       // _buildPostThreadWithImage(),
                //     ],
                //   ),
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: ListView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: _buildPostThread(index, "popular"),
                          onTap: () {
                            Navigator.pushNamed(context, detailThread,
                                arguments: provider.popular[index].sId);
                          },
                        );
                      },
                      itemCount: provider.threads.length,
                      shrinkWrap: true,
                    ))
                  ],
                ),
              ]));
        },
      ),
    );
  }

  Widget _buildPostThread(int index, String type) {
    var provider = Provider.of<AllTopicsViewModel>(context, listen: false);
    Thread thread = Thread();
    if (type == thread) {
      thread = provider.threads[index];
    } else {
      thread = provider.popular[index];
    }
    var liked = thread.isLiked ?? false;
    return Container(
      color: Color(0xffeeeeee),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  Text(thread.creator!.displayName ?? ""),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        color: AppColors.kcDarkestWhite,
                        shape: BoxShape.circle),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Follow",
                    style: body1Semi,
                  ),
                ],
              ),
              subtitle: Text(between(
                  DateTime.parse(thread.updatedAt ?? "").toLocal(),
                  DateTime.now())),
              leading: Image.asset('assets/Ellipse 43.png'),
              trailing: GestureDetector(
                onTap: () {
                  other(thread);
                },
                child: Image.asset(
                  'assets/icon_more.png',
                  height: 24,
                  width: 24,
                ),
              ),
            ),
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
                thread.topic!.topic ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      thread.title ?? "",
                      style: body1Bold,
                    ),
                    if (thread.imageURL != "")
                      Container(
                          margin: spacing8Top,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network('${thread.imageURL}')),
                    Text(thread.description ?? ""),
                    SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      GestureDetector(
                        onTap: () {
                          if (liked) {
                            provider.unlikeThread(index, type, widget.topicId);
                          } else {
                            provider.likeThread(index, type, widget.topicId);
                          }
                        },
                        child: Container(
                          child: liked
                              ? Row(
                                  children: [
                                    ImageIcon(
                                      AssetImage('assets/icon_like2.png'),
                                      color: AppColors.kcInfoColor,
                                    ),
                                    Text(thread.totalLike.toString(),
                                        style: captionSemi.copyWith(
                                          color: AppColors.kcInfoColor,
                                        ))
                                  ],
                                )
                              : Row(
                                  children: [
                                    Image.asset('assets/icon_like1.png',
                                        height: 24, width: 24),
                                    Text(thread.totalLike.toString()),
                                  ],
                                ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              builder: (context) {
                                return CommentScreen(
                                  threadId: thread.sId ?? "",
                                );
                              });
                        },
                        child: Row(
                          children: [
                            Image.asset('assets/icon_comment.png',
                                height: 24, width: 24),
                            Text(thread.totalComment.toString()),
                          ],
                        ),
                      ),
                    ]),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void other(Thread thread) {
    var provider = Provider.of<AllTopicsViewModel>(context, listen: false);
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
                            provider.unfollowThread(
                                thread.sId!, widget.topicId);
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
                            provider.followThread(thread.sId!, widget.topicId);
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
                            provider.unbookmarkThread(
                                thread.sId!, widget.topicId);
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
                            provider.bookmarkThread(
                                thread.sId!, widget.topicId);
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
}

// ListTile _buildProfileThreadFake() {
//   return
// }

Container _buildThread() {
  return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why is Indonesia the only member of G20 from Southeast Asia if some country is better (Malaysia or Singapore)?',
            style: body1Bold,
          ),
          Text(
              'Because Indonesia’s membership within the G20 isn’t just because of economic reasons. The G20 is practically speaking a regional power forum where regional powers'),
          SizedBox(
            height: 10,
          ),
          Row(children: [
            Row(
              children: [
                Image.asset('assets/icon_like1.png', height: 24, width: 24),
                Text('100'),
              ],
            ),
            SizedBox(width: 10),
            Row(
              children: [
                Image.asset('assets/icon_comment.png', height: 24, width: 24),
                Text('15'),
              ],
            ),
          ]),
        ],
      ));
}

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
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 12, right: 12),
              child: Text(
                'Histori',
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
            // onTap: () {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (_) => FollowAccountScreen()));
            // },
            child: Text(
          'Ade Winda',
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
    subtitle: Text('20m ago'),
    leading: Image.asset('assets/Ellipse 42.png'),
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
          'What are the differences between the ancient Turks, the proto-Turks, and the modern Turks?',
          style: body1Bold,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset('assets/image 1.png'),
        ),
        Text(
            'Early proto-Turks, Aldy-Bel and Sagly-Uyuk culture in Southern Siberia, Scytho-Siberian. The ANE are also argued to have harbored the genes for blonde hair at high frequenc...'),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Image.asset('assets/icon_like1.png', height: 24, width: 24),
            Text('42'),
            SizedBox(
              width: 10,
            ),
            Image.asset('assets/icon_comment.png', height: 24, width: 24),
            Text('10'),
          ],
        )
      ],
    ),
  );
}
