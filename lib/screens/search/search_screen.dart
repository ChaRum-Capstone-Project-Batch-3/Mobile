import 'package:fgd_flutter/models/thread/thread.dart';
import 'package:fgd_flutter/providers/bookmark_view_model.dart';
import 'package:fgd_flutter/models/bookmark/bookmark_response.dart';
import 'package:fgd_flutter/providers/search_thread_view_model.dart';
import 'package:fgd_flutter/screens/search/widget/recent_search.dart';
import 'package:fgd_flutter/screens/thread_detail/widgets/comment_screen.dart';
import 'package:fgd_flutter/shared/router.dart';
import 'package:fgd_flutter/state/search_thread_state.dart';
import 'package:flutter/material.dart';
import 'package:fgd_flutter/shared/charum_ui.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:fgd_flutter/shared/helper.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    Provider.of<SearchThreadViewModel>(context, listen: false).getRecent();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Provider.of<SearchThreadViewModel>(context, listen: false)
        .teSearch
        .dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchThreadViewModel>(builder: (context, provider, child) {
      final teSearch = provider.teSearch;
      return WillPopScope(
        onWillPop: () async {
          provider.changeState(SearchThreadState.iddle);
          return true;
        },
        child: Scaffold(
          backgroundColor: AppColors.kcBaseWhite,
          appBar: AppBar(
            toolbarHeight: 70,
            backgroundColor: AppColors.kcBaseWhite,
            foregroundColor: AppColors.kcBaseBlack,
            elevation: 0,
            title: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 8, right: 16),
              padding: spacing16Vertical,
              child: TextFormField(
                controller: teSearch,
                onEditingComplete: () {
                  if (teSearch.text.toLowerCase().toUpperCase().trim() != '') {
                    provider.addRecent(teSearch.text);
                    provider.searchThread(teSearch.text);
                  }
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.kcDarkWhite,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  hintText: "Search",
                  prefixIcon: Container(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 20, right: 10),
                    child: Image.asset(
                      height: 24,
                      width: 24,
                      'assets/icon_search_normal.png',
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                ),
              ),
            ),
            centerTitle: true,
          ),
          body: bodySearch(context),
        ),
      );
    });
  }

  Widget followedWidget() {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: AppColors.kcDarkWhite,
            child: Container(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Container(
                      color: AppColors.kcBaseWhite,
                      padding: spacing16All,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.kcPrimaryColor,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                BoxText.body2Semi("Chris")
                              ],
                            ),
                          ),
                          Container(
                            child: OutlinedButton(
                              child:
                                  BoxText.buttonSemi("Followed", TextStyle()),
                              onPressed: () {},
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                )),
                                side: MaterialStateProperty.all<BorderSide>(
                                    BorderSide(
                                  width: 1,
                                  color: AppColors.kcPrimaryColor!.shade500,
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ),
      ],
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

  Widget threadsWidget(BuildContext context) {
    var provider = Provider.of<SearchThreadViewModel>(context, listen: false);
    var threads = provider.thread;
    return threads.length > 0
        ? Column(
            children: [
              Expanded(
                child: Container(
                  color: AppColors.kcDarkWhite,
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
                              arguments: provider.thread[index].sId);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 10, bottom: 10, left: 16, right: 16),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                  // Container(
                                                  //   margin: spacing8Horizontal,
                                                  //   width: 4,
                                                  //   height: 4,
                                                  //   decoration: BoxDecoration(
                                                  //     color: AppColors
                                                  //         .kcDarkestWhite,
                                                  //     shape: BoxShape.circle,
                                                  //   ),
                                                  // ),
                                                  // GestureDetector(
                                                  //   child: BoxText.captionSemi(
                                                  //     "Follow",
                                                  //     color:
                                                  //         AppColors.kcInfoColor,
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                              BoxText.body3(
                                                diff.toString(),
                                                color:
                                                    AppColors.kcLightestBlack,
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
                                        other(provider.thread[index]);
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
                              SizedBox(height: 12),
                              if (threads[index].imageURL != "")
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: Container(
                                      child: Image.network(
                                          '${threads[index].imageURL}')),
                                ),
                              Container(
                                margin: spacing8Top,
                                child: BoxText.caption(
                                    threads[index].description!),
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
                                                color:
                                                    AppColors.kcLightestBlack,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              BoxText.captionSemi(
                                                threads[index]
                                                    .totalLike
                                                    .toString(),
                                                color:
                                                    AppColors.kcLightestBlack,
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
                                            AssetImage(
                                                'assets/icon_comment.png'),
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

  Widget bodySearch(BuildContext context) {
    final provider = Provider.of<SearchThreadViewModel>(context, listen: false);
    switch (provider.state) {
      case SearchThreadState.iddle:
        return RecentSearchScreen(recent: provider.recentSearch);
      case SearchThreadState.error:
        return error();
    }
    return tab(context);
  }

  Widget error() {
    return Center(
      child: Container(
        child: Text(
          "Error",
          style: heading2Semi,
        ),
      ),
    );
  }

  Widget tab(BuildContext context) {
    final provider = Provider.of<SearchThreadViewModel>(context, listen: false);
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          Center(
            child: TabBar(
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
                      ImageIcon(AssetImage('assets/threads.png')),
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
                      ImageIcon(AssetImage('assets/star.png')),
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
                Tab(
                  child: Row(
                    children: [
                      ImageIcon(AssetImage('assets/followed.png')),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Followed",
                        style: subtitle2Semi,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Expanded(
            child: TabBarView(
              children: [
                provider.state == SearchThreadState.loaded
                    ? Container(
                        color: AppColors.kcDarkerWhite,
                        child: threadsWidget(context),
                      )
                    : Container(
                        color: AppColors.kcDarkerWhite,
                        child: loadingThread(),
                      ),
                provider.state == SearchThreadState.loaded
                    ? Container(
                        color: AppColors.kcDarkerWhite,
                        child: popularWidget(context),
                      )
                    : Container(
                        color: AppColors.kcDarkerWhite,
                        child: loadingThread(),
                      ),
                Container(
                  color: AppColors.kcDarkerWhite,
                  child: followedWidget(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget popularWidget(BuildContext context) {
    var provider = Provider.of<SearchThreadViewModel>(context, listen: false);
    var threads = provider.popular;
    return threads.length > 0
        ? Column(
            children: [
              Expanded(
                child: Container(
                  color: AppColors.kcDarkWhite,
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
                              arguments: provider.thread[index].sId);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 10, bottom: 10, left: 16, right: 16),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                  // Container(
                                                  //   margin: spacing8Horizontal,
                                                  //   width: 4,
                                                  //   height: 4,
                                                  //   decoration: BoxDecoration(
                                                  //     color: AppColors
                                                  //         .kcDarkestWhite,
                                                  //     shape: BoxShape.circle,
                                                  //   ),
                                                  // ),
                                                  // GestureDetector(
                                                  //   child: BoxText.captionSemi(
                                                  //     "Follow",
                                                  //     color:
                                                  //         AppColors.kcInfoColor,
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                              BoxText.body3(
                                                diff.toString(),
                                                color:
                                                    AppColors.kcLightestBlack,
                                              )
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
                                      onTap: () {
                                        other(provider.thread[index]);
                                      },
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
                              SizedBox(height: 12),
                              if (threads[index].imageURL != "")
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: Container(
                                      child: Image.network(
                                          '${threads[index].imageURL}')),
                                ),
                              Container(
                                margin: spacing8Top,
                                child: BoxText.caption(
                                    threads[index].description!),
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
                                                  index, "popular");
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
                                                  index, "popular");
                                              // provider.getBookmark();
                                            },
                                            child: Row(children: [
                                              ImageIcon(
                                                AssetImage(
                                                    'assets/icon_like1.png'),
                                                color:
                                                    AppColors.kcLightestBlack,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              BoxText.captionSemi(
                                                threads[index]
                                                    .totalLike
                                                    .toString(),
                                                color:
                                                    AppColors.kcLightestBlack,
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
                                            AssetImage(
                                                'assets/icon_comment.png'),
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

  void comment(Thread thread) {
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
  }

  void other(Thread thread) {
    var provider = Provider.of<SearchThreadViewModel>(context, listen: false);
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
}
