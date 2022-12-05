import 'dart:ui';

import 'package:fgd_flutter/screens/search/widget/recent_search.dart';
import 'package:fgd_flutter/shared/app_colors.dart';
import 'package:fgd_flutter/shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fgd_flutter/shared/charum_ui.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController teSearch = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    teSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kcBaseWhite,
        appBar: AppBar(
          backgroundColor: AppColors.kcBaseWhite,
          elevation: 0,
          title: Container(
            margin: spacing20Horizontal,
            padding: spacing16Vertical,
            child: TextFormField(
              controller: teSearch,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                hintText: "Search",
                prefixIcon: Icon(
                  Icons.search_outlined,
                  size: 30,
                ),
                contentPadding: spacing32Horizontal,
              ),
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: spacing16Right,
              child: GestureDetector(
                child: Icon(
                  Icons.filter_alt_outlined,
                  color: AppColors.kcDarkestWhite,
                ),
              ),
            )
          ],
        ),
        body: teSearch.text.length > 0
            ? DefaultTabController(
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
                                Icon(
                                  Icons.note_outlined,
                                ),
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
                                Icon(
                                  Icons.star_outline_rounded,
                                ),
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
                                Icon(
                                  Icons.note_add_outlined,
                                ),
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
                          Container(
                            color: AppColors.kcDarkestWhite,
                            child: threadsWidget(),
                          ),
                          Container(
                            color: AppColors.kcDarkestWhite,
                            child: popularWidget(),
                          ),
                          Container(
                            color: AppColors.kcDarkestWhite,
                            child: followedWidget(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : RecentSearchScreen());
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

  Widget threadsWidget() {
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
                                          BoxText.captionSemi("Name"),
                                          Container(
                                            margin: spacing8Horizontal,
                                            width: 4,
                                            height: 4,
                                            decoration: BoxDecoration(
                                              color: AppColors.kcDarkestWhite,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          GestureDetector(
                                            child: BoxText.captionSemi(
                                              "Follow",
                                              color: AppColors.kcInfoColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      BoxText.body3(
                                        "2d ago",
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
                              child: Icon(Icons.menu),
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
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: BoxText.caption(
                          "Movie",
                          color: AppColors.kcLighterBlack,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      BoxText.subtitle2Semi(
                          "What do you think of Timothee Chris?"),
                      Container(
                        margin: spacing8Top,
                        child: BoxText.caption(
                            "Absolutely love him. First saw him in Lady Bird and I was a little shocked because I had thought he was attractive and was excited to see him act, but he was such a jerk in that "),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            child: GestureDetector(
                              child: Row(children: [
                                Icon(
                                  Icons.thumb_up_alt_outlined,
                                  color: AppColors.kcLightestBlack,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                BoxText.captionSemi(
                                  "602",
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
                                Icon(
                                  Icons.comment_rounded,
                                  color: AppColors.kcLightestBlack,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                BoxText.captionSemi(
                                  "602",
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
    );
  }

  Widget popularWidget() {
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
                                          BoxText.captionSemi("Name"),
                                          Container(
                                            margin: spacing8Horizontal,
                                            width: 4,
                                            height: 4,
                                            decoration: BoxDecoration(
                                              color: AppColors.kcDarkestWhite,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          GestureDetector(
                                            child: BoxText.captionSemi(
                                              "Follow",
                                              color: AppColors.kcInfoColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      BoxText.body3(
                                        "2d ago",
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
                              child: Icon(Icons.menu),
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
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: BoxText.caption(
                          "Movie",
                          color: AppColors.kcLighterBlack,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      BoxText.subtitle2Semi(
                          "What do you think of Timothee Chris?"),
                      Container(
                        margin: spacing8Top,
                        child: BoxText.caption(
                            "Absolutely love him. First saw him in Lady Bird and I was a little shocked because I had thought he was attractive and was excited to see him act, but he was such a jerk in that "),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            child: GestureDetector(
                              child: Row(children: [
                                Icon(
                                  Icons.thumb_up_alt_outlined,
                                  color: AppColors.kcLightestBlack,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                BoxText.captionSemi(
                                  "602",
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
                                Icon(
                                  Icons.comment_rounded,
                                  color: AppColors.kcLightestBlack,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                BoxText.captionSemi(
                                  "602",
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
    );
  }
}
