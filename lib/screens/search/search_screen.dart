import 'package:fgd_flutter/providers/search_thread_view_model.dart';
import 'package:fgd_flutter/screens/search/widget/recent_search.dart';
import 'package:fgd_flutter/state/search_thread_state.dart';
import 'package:flutter/material.dart';
import 'package:fgd_flutter/shared/charum_ui.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
            backgroundColor: AppColors.kcBaseWhite,
            foregroundColor: AppColors.kcBaseBlack,
            elevation: 0,
            title: Container(
              margin: spacing8Horizontal,
              padding: spacing16Vertical,
              child: TextFormField(
                controller: teSearch,
                onEditingComplete: () {
                  if (teSearch.text.trim() != '') {
                    provider.addRecent(teSearch.text);
                    provider.searchThread(teSearch.text);
                  }
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  hintText: "Search",
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    size: 30,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                ),
              ),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: spacing16Right,
                child: GestureDetector(
                  child: ImageIcon(
                    AssetImage('assets/icon_filter_search.png'),
                    color: AppColors.kcLightestBlack,
                  ),
                ),
              )
            ],
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
            margin: spacing16Vertical,
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
                            child: BoxText.buttonSemi("Followed", TextStyle()),
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

  Widget threadsWidget(BuildContext context) {
    var threads =
        Provider.of<SearchThreadViewModel>(context, listen: false).thread;
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
                      return Container(
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
                                        backgroundColor:
                                            AppColors.kcPrimaryColor,
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
                                  child: GestureDetector(
                                    child: Row(children: [
                                      ImageIcon(
                                        AssetImage('assets/icon_like1.png'),
                                        color: AppColors.kcLightestBlack,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      BoxText.captionSemi(
                                        threads[index].totalLike.toString(),
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
                                    child: Row(children: [
                                      ImageIcon(
                                        AssetImage('assets/icon_comment.png'),
                                        color: AppColors.kcLightestBlack,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      BoxText.captionSemi(
                                        threads[index].totalComment.toString(),
                                        color: AppColors.kcLightestBlack,
                                      )
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
    var threads =
        Provider.of<SearchThreadViewModel>(context, listen: false).popular;
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
                      return Container(
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
                                        backgroundColor:
                                            AppColors.kcPrimaryColor,
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
                                  child: GestureDetector(
                                    child: Row(children: [
                                      ImageIcon(
                                        AssetImage('assets/icon_like1.png'),
                                        color: AppColors.kcLightestBlack,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      BoxText.captionSemi(
                                        threads[index].totalLike.toString(),
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
