import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:fgd_flutter/screens/thread_detail/widgets/comment_screen.dart';
import 'package:fgd_flutter/shared/router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
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
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    Provider.of<HomeThreadViewModel>(context, listen: false).getAllThread();
    super.didChangeDependencies();
  }

  bool actionLike = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeThreadViewModel>(builder: (context, provider, child) {
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
                      InkWell(child: Image.asset("assets/notification.png")),
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
                  padding: EdgeInsets.only(left: 18, right: 18, top: 8, bottom: 8),
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
                      style: heading3Bold.copyWith(color: AppColors.kcPrimaryColor),
                    ),
                  ],
                ),
              ),
            ),
            body: TabBarView(
              children: [
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
    var provider = Provider.of<HomeThreadViewModel>(context, listen: false);
    var threads = provider.thread;
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
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 12, right: 12),
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
    title: Text('Muhammad Sumbul * Following'),
    subtitle: Text('1h ago'),
    leading: Image.asset('assets/Ellipse 43.png'),
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
