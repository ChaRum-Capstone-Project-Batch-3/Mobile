import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:fgd_flutter/models/thread/thread.dart';
import 'package:fgd_flutter/screens/thread_detail/widgets/comment_screen.dart';
import 'package:fgd_flutter/shared/router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../models/home/home_thread_response.dart';
import '../../shared/helper.dart';
import '../../state/home_thread_state.dart';
import '/shared/app_colors.dart';
import '/shared/styles.dart';
import 'package:fgd_flutter/shared/charum_ui.dart';
import 'package:flutter/material.dart';
import 'package:fgd_flutter/providers/home_thread_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   Provider.of<HomeThreadViewModel>(context, listen: false).getThread();
  //   Provider.of<HomeThreadViewModel>(context, listen: false).getPopular();
  //   Provider.of<HomeThreadViewModel>(context, listen: false).getFollow();
  //   super.didChangeDependencies();
  // }

  @override
  void initState() {
    Provider.of<HomeThreadViewModel>(context, listen: false).init();
    print("Appan tuh");
    super.initState();
  }

  bool actionLike = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeThreadViewModel>(
      builder: (context, provider, child) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(120),
              child: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                actions: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, notif);
                        },
                        child: Image.asset("assets/notification.png")
                      ),
                      SizedBox(width: 15),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, search);
                        },
                        child: Image.asset(
                          "assets/search-normal.png",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ],
                bottom: TabBar(
                  padding:
                      EdgeInsets.only(left: 18, right: 18, top: 8, bottom: 8),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
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
                            style: body1.copyWith(fontWeight: FontWeight.bold),
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
                            style: body1.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        children: [
                          ImageIcon(AssetImage("assets/followed.png")),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Followed",
                            style: body1.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                title: Row(
                  children: [
                    Image.asset("assets/logocharum.png"),
                    SizedBox(width: 5),
                    Text(
                      'Charum',
                      style: heading3Bold.copyWith(
                          color: AppColors.kcPrimaryColor),
                    ),
                  ],
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    children: [
                      provider.state == HomeThreadState.loaded
                          ? Container(
                              color: AppColors.kcDarkerWhite,
                              child: threadsWidget(context),
                            )
                          : Container(
                              color: AppColors.kcDarkerWhite,
                              child: loadingThread(),
                            ),
                      provider.state == HomeThreadState.loaded
                          ? Container(
                              color: AppColors.kcDarkerWhite,
                              child: popularsWidget(context),
                            )
                          : Container(
                              color: AppColors.kcDarkerWhite,
                              child: loadingThread(),
                            ),
                      provider.state == HomeThreadState.loaded
                          ? Container(
                              color: AppColors.kcDarkerWhite,
                              child: followedsWidget(context),
                            )
                          : Container(
                              color: AppColors.kcDarkerWhite,
                              child: loadingThread(),
                            ),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.kcPrimaryColor,
              onPressed: () {
                Navigator.pushNamed(context, createThread);
              },
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }

  Widget threadsWidget(BuildContext context) {
    var provider = Provider.of<HomeThreadViewModel>(context, listen: false);
    var threads = provider.allThread;
    return threads.length > 0
        ? Column(
            children: [
              Expanded(
                child: Container(
                  margin: spacing16All,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: threads.length,
                    itemBuilder: (context, index) {
                      final date =
                          DateTime.parse(threads[index].createdAt!).toLocal();
                      final now = DateTime.now();
                      final diff = between(date, now);
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, detailThread,
                              arguments: threads[index].sId);
                        },
                        child: Container(
                          margin: spacing8Bottom,
                          padding: spacing16All,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: AppColors.kcBaseWhite,
                          ),
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
                                          backgroundImage: NetworkImage(
                                              threads[index]
                                                  .creator!
                                                  .profilePictureURL!),
                                        ),
                                        Container(
                                          margin: spacing8Left,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  BoxText.captionSemi(
                                                      threads[index]
                                                          .creator!
                                                          .displayName!),
                                                  Container(
                                                    margin: spacing8Horizontal,
                                                    width: 4,
                                                    height: 4,
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .kcDarkestWhite,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    child: BoxText.captionSemi(
                                                      "Follow",
                                                      color:
                                                          AppColors.kcInfoColor,
                                                    ),
                                                  ),
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
                                      onTap: () {
                                        other(provider.allThread[index]);
                                      },
                                      child: ImageIcon(
                                          AssetImage('assets/icon_more.png')),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: spacing16Top,
                                padding: EdgeInsets.only(
                                    top: 5, bottom: 5, left: 12, right: 12),
                                decoration: BoxDecoration(
                                  color: AppColors.kcDarkerWhite,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                child: BoxText.caption(
                                  threads[index].topic!.topic!,
                                  color: AppColors.kcLighterBlack,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              BoxText.subtitle2Semi(threads[index].title!),
                              SizedBox(height: 8,),
                              if (threads[index].imageURL != "")
                                ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  child: Container(
                                      child: Image.network('${threads[index].imageURL}')
                                    ),
                                ),
                              Container(
                                margin: spacing8Top,
                                child:
                                    BoxText.caption(threads[index].description!),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: threads[index].isLiked!
                                        ? GestureDetector(
                                            onTap: () {
                                              provider.unlikeThread(
                                                  index, "thread");
                                              // provider.getBookmark();
                                            },
                                            child: Row(children: [
                                              ImageIcon(
                                                AssetImage(
                                                    'assets/icon_like2.png'),
                                                color: AppColors.kcInfoColor,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              BoxText.captionSemi(
                                                threads[index]
                                                    .totalLike
                                                    .toString(),
                                                color: AppColors.kcInfoColor,
                                              )
                                            ]),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              provider.likeThread(
                                                  index, "thread");
                                              // provider.getBookmark();
                                            },
                                            child: Row(children: [
                                              ImageIcon(
                                                AssetImage(
                                                    'assets/icon_like1.png'),
                                                color: AppColors.kcLightestBlack,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              BoxText.captionSemi(
                                                threads[index]
                                                    .totalLike
                                                    .toString(),
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
                                                threadId:
                                                    threads[index].sId ?? "",
                                              );
                                            });
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
                                            threads[index]
                                                .totalComment
                                                .toString(),
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
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          )
        : noContent();
  }

  Widget popularsWidget(BuildContext context) {
    var provider = Provider.of<HomeThreadViewModel>(context, listen: false);
    var threads = provider.popularThread;
    print(threads.length.toString());
    return threads.length > 0
        ? Column(
            children: [
              Expanded(
                child: Container(
                  margin: spacing16All,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: threads.length,
                    itemBuilder: (context, index) {
                      final date =
                          DateTime.parse(threads[index].createdAt!).toLocal();
                      final now = DateTime.now();
                      final diff = between(date, now);
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, detailThread,
                              arguments: threads[index].sId);
                        },
                        child: Container(
                          margin: spacing8Bottom,
                          padding: spacing16All,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: AppColors.kcBaseWhite,
                          ),
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
                                          backgroundImage: NetworkImage(
                                              threads[index]
                                                  .creator!
                                                  .profilePictureURL!),
                                        ),
                                        Container(
                                          margin: spacing8Left,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  BoxText.captionSemi(
                                                      threads[index]
                                                          .creator!
                                                          .displayName!),
                                                  Container(
                                                    margin: spacing8Horizontal,
                                                    width: 4,
                                                    height: 4,
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .kcDarkestWhite,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    child: BoxText.captionSemi(
                                                      "Follow",
                                                      color:
                                                          AppColors.kcInfoColor,
                                                    ),
                                                  ),
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
                                      onTap: () {
                                        other(provider.popularThread[index]);
                                      },
                                      child: ImageIcon(
                                          AssetImage('assets/icon_more.png')),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: spacing16Top,
                                padding: EdgeInsets.only(
                                    top: 5, bottom: 5, left: 12, right: 12),
                                decoration: BoxDecoration(
                                  color: AppColors.kcDarkerWhite,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                child: BoxText.caption(
                                  threads[index].topic!.topic!,
                                  color: AppColors.kcLighterBlack,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              BoxText.subtitle2Semi(threads[index].title!),
                              SizedBox(height: 8,),
                              if (threads[index].imageURL != "")
                                ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  child: Container(
                                      child: Image.network('${threads[index].imageURL}')
                                    ),
                                ),
                              Container(
                                margin: spacing8Top,
                                child:
                                    BoxText.caption(threads[index].description!),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: threads[index].isLiked!
                                        ? GestureDetector(
                                            onTap: () {
                                              provider.unlikeThread(
                                                  index, "thread");
                                              // provider.getBookmark();
                                            },
                                            child: Row(children: [
                                              ImageIcon(
                                                AssetImage(
                                                    'assets/icon_like2.png'),
                                                color: AppColors.kcInfoColor,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              BoxText.captionSemi(
                                                threads[index]
                                                    .totalLike
                                                    .toString(),
                                                color: AppColors.kcInfoColor,
                                              )
                                            ]),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              provider.likeThread(
                                                  index, "thread");
                                              // provider.getBookmark();
                                            },
                                            child: Row(children: [
                                              ImageIcon(
                                                AssetImage(
                                                    'assets/icon_like1.png'),
                                                color: AppColors.kcLightestBlack,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              BoxText.captionSemi(
                                                threads[index]
                                                    .totalLike
                                                    .toString(),
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
                                                threadId:
                                                    threads[index].sId ?? "",
                                              );
                                            });
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
                                            threads[index]
                                                .totalComment
                                                .toString(),
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
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          )
        : noContent();
  }

  Widget followedsWidget(BuildContext context) {
    var provider = Provider.of<HomeThreadViewModel>(context, listen: false);
    var threads = provider.followedThread;
    return threads.length > 0
        ? Column(
            children: [
              Expanded(
                child: Container(
                  margin: spacing16All,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: threads.length,
                    itemBuilder: (context, index) {
                      final date =
                          DateTime.parse(threads[index].createdAt!).toLocal();
                      final now = DateTime.now();
                      final diff = between(date, now);
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, detailThread,
                              arguments: threads[index].thread!.sId);
                        },
                        child: Container(
                          margin: spacing8Bottom,
                          padding: spacing16All,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: AppColors.kcBaseWhite,
                          ),
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
                                          backgroundImage: NetworkImage(
                                              threads[index]
                                                  .thread!
                                                  .creator!
                                                  .profilePictureURL!),
                                        ),
                                        Container(
                                          margin: spacing8Left,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  BoxText.captionSemi(
                                                      threads[index]
                                                          .thread!
                                                          .creator!
                                                          .displayName!),
                                                  Container(
                                                    margin: spacing8Horizontal,
                                                    width: 4,
                                                    height: 4,
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .kcDarkestWhite,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    child: BoxText.captionSemi(
                                                      "Follow",
                                                      color:
                                                          AppColors.kcInfoColor,
                                                    ),
                                                  ),
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
                                      onTap: () {
                                        other(provider
                                            .followedThread[index].thread!);
                                      },
                                      child: ImageIcon(
                                          AssetImage('assets/icon_more.png')),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: spacing16Top,
                                padding: EdgeInsets.only(
                                    top: 5, bottom: 5, left: 12, right: 12),
                                decoration: BoxDecoration(
                                  color: AppColors.kcDarkerWhite,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                child: BoxText.caption(
                                  threads[index].thread!.topic!.topic!,
                                  color: AppColors.kcLighterBlack,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              BoxText.subtitle2Semi(
                                  threads[index].thread!.title!),
                                  SizedBox(height: 8,),
                                  if (threads[index].thread!.imageURL != "")
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      child: Container(
                                          child: Image.network('${threads[index].thread!.imageURL}')
                                        ),
                                    ),
                              Container(
                                margin: spacing8Top,
                                child: BoxText.caption(
                                    threads[index].thread!.description!),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: threads[index].thread!.isLiked!
                                        ? GestureDetector(
                                            onTap: () {
                                              provider.unlikeThread(
                                                  index, "followed");
                                              // provider.getBookmark();
                                            },
                                            child: Row(children: [
                                              ImageIcon(
                                                AssetImage(
                                                    'assets/icon_like2.png'),
                                                color: AppColors.kcInfoColor,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              BoxText.captionSemi(
                                                threads[index]
                                                    .thread!
                                                    .totalLike
                                                    .toString(),
                                                color: AppColors.kcInfoColor,
                                              )
                                            ]),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              provider.likeThread(
                                                  index, "followed");
                                              // provider.getBookmark();
                                            },
                                            child: Row(children: [
                                              ImageIcon(
                                                AssetImage(
                                                    'assets/icon_like1.png'),
                                                color: AppColors.kcLightestBlack,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              BoxText.captionSemi(
                                                threads[index]
                                                    .thread!
                                                    .totalLike
                                                    .toString(),
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
                                                threadId:
                                                    threads[index].thread!.sId ??
                                                        "",
                                              );
                                            });
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
                                            threads[index]
                                                .thread!
                                                .totalComment
                                                .toString(),
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
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          )
        : noContent();
  }

  Widget noContent() {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/not_found.png'),
            Text(
              "We can’t find any what you search.",
              style: subtitle1Semi.copyWith(
                color: AppColors.kcLightestBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void other(Thread thread) {
    var provider = Provider.of<HomeThreadViewModel>(context, listen: false);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
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
                              child:
                                  ImageIcon(AssetImage('assets/icon_more.png')),
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
