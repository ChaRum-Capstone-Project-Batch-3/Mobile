import 'package:fgd_flutter/providers/thread_detail_view_model.dart';
import 'package:fgd_flutter/screens/thread_detail/widgets/comment_body.dart';
import 'package:fgd_flutter/shared/app_colors.dart';
import 'package:fgd_flutter/shared/helper.dart';
import 'package:fgd_flutter/shared/router.dart';
import 'package:fgd_flutter/shared/spacing.dart';
import 'package:fgd_flutter/shared/styles.dart';
import 'package:fgd_flutter/state/thread_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../shared/box_text.dart';
import 'widgets/comment_screen.dart';

class ThreadDetailScreen extends StatefulWidget {
  const ThreadDetailScreen({super.key, required this.id});

  final String id;
  @override
  State<ThreadDetailScreen> createState() => _ThreadDetailScreenState();
}

class _ThreadDetailScreenState extends State<ThreadDetailScreen> {
  bool actionFollowAccount = true;
  bool actionLike = true;
  bool actionFollowThread = true;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ThreadDetailViewModel>(context, listen: false)
        .initial(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThreadDetailViewModel>(
      builder: (context, provider, child) {
        var followed = provider.thread.isFollowed ?? false;
        var bookmarked = provider.thread.isBookmarked ?? false;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 83, 50, 50),
              ),
            ),
            foregroundColor: AppColors.kcBaseBlack,
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            actions: [
              GestureDetector(
                  onTap: () {
                    if (provider.thread.isBookmarked!) {
                      provider.unbookmarkThread(widget.id);
                    } else {
                      provider.bookmarkThread(widget.id);
                      _buildSnackBarAddBookmark();
                    }
                  },
                  child: bookmarked
                      ? Container(
                          width: 25,
                          height: 25,
                          child: Image.asset(
                            "assets/icon_remove_bookmark.png",
                            scale: 1,
                          ),
                        )
                      : ImageIcon(
                          AssetImage(
                            "assets/icon_add_bookmark_bottom_sheet.png",
                          ),
                          color: AppColors.kcBaseBlack,
                        )),
              const SizedBox(
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
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          body: body(),
          //bottomnavigation
          bottomNavigationBar: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Color(0xffe3e3e3))),
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 12, bottom: 12),
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: provider.thread.isLiked ?? false
                                ? GestureDetector(
                                    onTap: () {
                                      provider.unlikeThread();
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
                                        provider.thread.totalLike.toString(),
                                        color: AppColors.kcInfoColor,
                                      )
                                    ]),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      provider.likeThread();
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
                                        provider.thread.totalLike.toString(),
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
                              onTap: () {
                                _buildComment();
                              },
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
                                    provider.thread.totalComment.toString(),
                                    color: AppColors.kcLightestBlack,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                          onTap: () {
                            if (followed) {
                              provider
                                  .unfollowThread(provider.thread.sId ?? "");
                            } else {
                              provider.followThread(provider.thread.sId ?? "");
                            }
                          },
                          child: followed
                              ? Text("Followed",
                                  style: captionSemi.copyWith(
                                    color: AppColors.kcLightestBlack,
                                  ))
                              : Text("Follow Thread",
                                  style: captionSemi.copyWith(
                                    color: AppColors.kcPrimaryColor,
                                  ))),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }

  Widget body() {
    var provider = Provider.of<ThreadDetailViewModel>(context, listen: false);
    var thread = provider.thread;

    switch (provider.state) {
      case ThreadDetailState.loading:
        return loadingThread();
      case ThreadDetailState.error:
        return Center(
          child: Container(
              child: Text(
            "ERROR",
            style: body2Bold,
          )),
        );
    }

    return Container(
      color: Color(0xfff1f3f5),
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Container(
            margin: spacing16Horizontal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xffececec),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, left: 15, right: 15),
                  child: Text(
                    '${provider.thread.topic?.topic}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Container(
                    child: Text(
                  '${provider.thread.title}',
                  style: heading3Semi,
                )),
                _buildProfileThread(),
                _buildThreadWithImage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loadingThread() {
    return Shimmer.fromColors(
        child: Container(
          color: Color(0xfff1f3f5),
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Container(
                margin: spacing16Horizontal,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xffececec),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 15, right: 15),
                    ),
                    Container(
                      width: 100,
                      height: 50,
                    ),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 30,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Color(0xffC7C7C7),
                                shape: BoxShape.circle),
                            width: 6,
                            height: 6,
                            child: const CircleAvatar(
                              backgroundColor: Color(0xffC7C7C7),
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 30,
                          ),
                        ],
                      ),
                      subtitle: Container(
                        height: 30,
                        width: 50,
                      ),
                      leading: Image.asset('assets/Ellipse 42.png'),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                          ),
                          Container(
                            width: 100,
                            height: 30,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        baseColor: AppColors.kcLightestBlack,
        highlightColor: AppColors.kcDarkerWhite);
  }

  ListTile _buildProfileThread() {
    var provider = Provider.of<ThreadDetailViewModel>(context, listen: false);
    var thread = provider.thread;
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('${provider.thread.creator?.displayName}'),
          const SizedBox(
            width: 5,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            decoration:
                BoxDecoration(color: Color(0xffC7C7C7), shape: BoxShape.circle),
            width: 6,
            height: 6,
            child: const CircleAvatar(
              backgroundColor: Color(0xffC7C7C7),
            ),
          ),
          GestureDetector(
              onTap: () {},
              child: const Text(
                'Follow',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              )),
        ],
      ),
      subtitle: Text(
          between(DateTime.parse(thread.createdAt!).toLocal(), DateTime.now())),
      leading: CircleAvatar(
          backgroundImage:
              NetworkImage('${provider.thread.creator?.profilePictureURL}'),
        )
    );
  }

  Container _buildThreadWithImage() {
    var provider = Provider.of<ThreadDetailViewModel>(context, listen: false);
    var thread = provider.thread;
    return Container(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (thread.imageURL != "")
            ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Container(
                child: Image.network('${provider.thread.imageURL}')
              ),
          ),
          SizedBox(height: 12),
          Text(
            '${provider.thread.description}',
            style: caption,
          ),
        ],
      ),
    );
  }

  void _buildMoreThread() {
    var provider = Provider.of<ThreadDetailViewModel>(context, listen: false);
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Container(
          alignment: Alignment.topLeft,
          height: 250,
          padding: const EdgeInsets.all(20),
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
              const SizedBox(
                height: 30,
              ),
              Container(
                child: provider.thread.isFollowed!
                    ? InkWell(
                        onTap: () {
                          provider.unfollowThread(provider.thread.sId!);
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            ImageIcon(AssetImage('assets/unfollow-thread.png')),
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
                          provider.followThread(provider.thread.sId!);
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
              const Divider(
                height: 20,
                color: Color(0xffDFDFDF),
              ),
              Container(
                child: provider.thread.isBookmarked!
                    ? InkWell(
                        onTap: () {
                          provider.unbookmarkThread(provider.thread.sId!);
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            ImageIcon(
                                AssetImage('assets/icon_remove_bookmark.png')),
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
                          provider.bookmarkThread(provider.thread.sId!);
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            ImageIcon(AssetImage('assets/icon_bookmark1.png')),
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
              const Divider(
                height: 20,
                color: Color(0xffDFDFDF),
              ),
              Row(children: [
                Image.asset('assets/icon_share_bottom_sheet.png',
                    height: 24, width: 24),
                const SizedBox(
                  width: 10,
                ),
                Text('Share', style: button),
              ]),
              const Divider(
                height: 20,
                color: Color(0xffDFDFDF),
              ),
              Row(children: [
                Image.asset('assets/icon_report_bottom_sheet.png',
                    height: 24, width: 24),
                const SizedBox(
                  width: 10,
                ),
                Text('Report thread', style: button),
              ]),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }

  // ignore: unused_element
  void _buildSnackBarAddBookmark() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: AppColors.kcPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 130,
            right: 20,
            left: 20),
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon_succes_add_bookmark_circle.png',
              height: 24,
              width: 24,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Thread added to your Bookmarks',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        )));
  }

  void _buildComment() {
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
            threadId: widget.id,
          );
        });
  }
}
