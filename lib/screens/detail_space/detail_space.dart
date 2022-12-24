import 'package:fgd_flutter/models/thread/thread.dart';
import 'package:fgd_flutter/providers/get_alltopics_view_model.dart';
import 'package:fgd_flutter/screens/thread_detail/widgets/comment_screen.dart';
import 'package:fgd_flutter/shared/helper.dart';
import 'package:fgd_flutter/shared/router.dart';
import 'package:fgd_flutter/state/space_state.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fgd_flutter/shared/charum_ui.dart';
import 'package:shimmer/shimmer.dart';

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
                          child: provider.state == SpaceState.loading
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      provider.topic.topic ?? "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    SizedBox(height: 5),
                                    Text(provider.topic.description ?? ""),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                )
                              : loadingTitleSpace()),
                      TabBar(
                        padding: EdgeInsets.only(
                            left: 18, right: 18, top: 8, bottom: 8),
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
                                ImageIcon(AssetImage("assets/threads.png")),
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
                                ImageIcon(AssetImage("assets/star.png")),
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
                          onTap: () {
                            Navigator.pushNamed(context, detailThread,
                                arguments: provider.threads[index].sId);
                          },
                          child: provider.state == SpaceState.loading
                              ? _buildPostThread(index, "thread")
                              : loadingThread(),
                        );
                      },
                      itemCount: provider.threads.length,
                      shrinkWrap: true,
                    ))
                  ],
                ),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(thread.creator!.displayName ?? ""),
                  const SizedBox(
                    width: 5,
                  ),
                  // Container(
                  //   width: 10,
                  //   height: 10,
                  //   decoration: BoxDecoration(
                  //       color: AppColors.kcDarkestWhite,
                  //       shape: BoxShape.circle),
                  // ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  // Text(
                  //   "Follow",
                  //   style: body1Semi,
                  // ),
                ],
              ),
              subtitle: Text(between(
                  DateTime.parse(thread.updatedAt ?? "").toLocal(),
                  DateTime.now())),
              leading: thread.creator!.profilePictureURL != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(
                          thread.creator!.profilePictureURL.toString()),
                    )
                  : CircleAvatar(
                      backgroundImage: AssetImage('assets/account_default.png'),
                    ),
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
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(bottom: 5, left: 15),
                decoration: BoxDecoration(
                  color: Color(0xffececec),
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 15, right: 15),
                child: Text(
                  thread.topic!.topic ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
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
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Container(
                            child: Image.network('${thread.imageURL}')),
                      ),
                    SizedBox(height: 12),
                    Text(
                      '${thread.description}',
                      style: caption,
                    ),
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
            height: 220,
            padding: spacing20All,
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                const SizedBox(
                  height: 16,
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
                Divider(
                  height: 20,
                  color: Color(0xffDFDFDF),
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
                              ImageIcon(AssetImage(
                                  'assets/icon_add_bookmark_bottom_sheet.png')),
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
                Divider(
                  height: 20,
                  color: Color(0xffDFDFDF),
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
                Divider(
                  height: 20,
                  color: Color(0xffDFDFDF),
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

  Widget loadingThread() {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: spacing16All,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 2,
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
                                              width: 80,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                color: AppColors.kcDarkestWhite,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                            ),
                                            // Container(
                                            //   margin: spacing8Horizontal,
                                            //   width: 4,
                                            //   height: 4,
                                            //   decoration: BoxDecoration(
                                            //     color: AppColors.kcDarkestWhite,
                                            //     shape: BoxShape.circle,
                                            //   ),
                                            // ),
                                            // Container(
                                            //   width: 50,
                                            //   height: 10,
                                            //   decoration: BoxDecoration(
                                            //     color: AppColors.kcDarkestWhite,
                                            //     borderRadius: BorderRadius.all(
                                            //       Radius.circular(10),
                                            //     ),
                                            //   ),
                                            // ),
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

  Widget loadingTitleSpace() {
    return Shimmer.fromColors(
      baseColor: AppColors.kcDarkestWhite,
      highlightColor: AppColors.kcDarkWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70,
            height: 25,
            decoration: BoxDecoration(
              color: AppColors.kcDarkestWhite,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: 180,
            height: 15,
            decoration: BoxDecoration(
              color: AppColors.kcDarkestWhite,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: 150,
            height: 15,
            decoration: BoxDecoration(
              color: AppColors.kcDarkestWhite,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
