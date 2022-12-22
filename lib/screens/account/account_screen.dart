import 'package:fgd_flutter/models/account/get_thread_user_response.dart';
import 'package:fgd_flutter/shared/charum_ui.dart';
import 'package:fgd_flutter/shared/router.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../providers/get_thread_user_view_model.dart';
import '../../providers/get_user_view_model.dart';
import '../../state/user_state.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final primaryColor = AppColors.kcPrimaryColor;
  final whiteColor = AppColors.kcBaseWhite;

  @override
  void didChangeDependencies() {
    Provider.of<GetThreadUserViewModel>(context, listen: false).getThreads();
    Provider.of<GetUserViewModel>(context, listen: false).getUsers();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    Provider.of<GetThreadUserViewModel>(context, listen: false)
        .initialThreads();
    Provider.of<GetUserViewModel>(context, listen: false).getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetUserViewModel>(builder: (context, provider, child) {
      return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 90,
              backgroundColor: Colors.white,
              title: Text(
                'Account',
                style: heading3Bold.copyWith(color: AppColors.kcPrimaryColor),
              ),
              actions: [
                GestureDetector(
                  onTap: (() {
                    _buildMoreAccount();
                  }),
                  child: Image.asset(
                    'assets/icon_more.png',
                    height: 24,
                    width: 24,
                  ),
                ),
                SizedBox(
                  width: 10,
                )
              ],
              elevation: 0.0,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(340),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                              height: 100,
                              width: 100,
                              child: provider.user.profilePictureURL != null
                                  ? CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        provider.user.profilePictureURL
                                            .toString(),
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/account_default.png'),
                                    )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      provider.user.displayName ?? "",
                      style: body1Bold.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      provider.user.userName ?? "",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _buildProfile(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 10, bottom: 10, left: 87, right: 8),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, editAccount);
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 34, right: 34),
                                child: Text(
                                  'Edit profile',
                                  style: body2Semi,
                                ),
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              )),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xfff4f4f4),
                              borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.all(11),
                          child: Image.asset(
                            'assets/icon_message.png',
                            height: 24,
                            width: 24,
                          ),
                        )
                      ],
                    ),
                    TabBar(
                      padding: EdgeInsets.only(
                          left: 18, right: 18, top: 8, bottom: 8),
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
                                style:
                                    body1.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            children: [
                              ImageIcon(AssetImage(
                                "assets/icon_about.png",
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "About",
                                style:
                                    body1.copyWith(fontWeight: FontWeight.bold),
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
            body: TabBarView(
              children: [
                Consumer<GetThreadUserViewModel>(
                  builder: (context, provider, child) {
                    return Container(
                        color: AppColors.kcDarkWhite, child: body(provider));
                  },
                ),
                Container(
                  color: Color(0xffeeeeee),
                  padding: EdgeInsets.only(top: 10),
                  child: SingleChildScrollView(
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(provider.user.biodata ?? ""),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Contact me in :'),
                          Text(provider.user.socialMedia ?? ""),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
    });
  }

  Widget _buildProfile() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, following);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                '1',
                style: buttonSemi,
              ),
              Text('Thread'),
            ],
          ),
          SizedBox(
            width: 50,
          ),
          Column(
            children: [
              Text('500', style: buttonSemi),
              Text('Following'),
            ],
          ),
          SizedBox(
            width: 50,
          ),
          Column(
            children: [
              Text(
                '44',
                style: buttonSemi,
              ),
              Text('Followers'),
            ],
          ),
        ],
      ),
    );
  }

  Widget body(GetThreadUserViewModel provider) {
    return Container(
      child: provider.threads.length > 0
          ? Container(
              color: AppColors.kcDarkWhite,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: provider.threads.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, detailThread,
                                  arguments: provider.threads[index].sId);
                            },
                            child: _buildPostThread(index));
                      },
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Container(
                margin: EdgeInsets.all(100),
                child: Text('haven\'t created a thread yet'),
              ),
            ),
    );
  }

  Container _buildPostThread(int index) {
    var provider = Provider.of<GetThreadUserViewModel>(context, listen: false);
    var thread = provider.threads[index];
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
            _buildProfileThread(index),
            Container(
              margin: spacing16Top,
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 12, right: 12),
              decoration: BoxDecoration(
                color: AppColors.kcDarkerWhite,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: BoxText.caption(
                thread.topic!.topic ?? '',
                color: AppColors.kcLighterBlack,
              ),
            ),
            _buildThread(index),
          ],
        ),
      ),
    );
  }

  Row _buildProfileThread(int index) {
    var provider = Provider.of<GetThreadUserViewModel>(context, listen: false);
    var thread = provider.threads[index];
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
                backgroundImage:
                    NetworkImage(thread.creator!.profilePictureURL!),
              ),
              Container(
                margin: spacing8Left,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoxText.captionSemi(thread.creator!.displayName!),
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
              other(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildThread(int index) {
    var provider = Provider.of<GetThreadUserViewModel>(context, listen: false);
    var thread = provider.threads[index];
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 4,
          ),
          BoxText.subtitle2Semi(thread.title ?? ''),
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                image: NetworkImage(thread.imageURL ?? ''),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            margin: spacing8Top,
            child: BoxText.caption(thread.description ?? ''),
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

  Widget loadingThread() {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: spacing16All,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 1,
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

  void other(int index) {
    var provider = Provider.of<GetThreadUserViewModel>(context, listen: false);

    var thread = provider.threads[index];
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
            height: 150,
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
                Row(
                  children: [
                    ImageIcon(AssetImage('assets/icon_share_bottom_sheet.png')),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Share',
                      style: button,
                    ),
                  ],
                ),
                Divider(
                  height: 20,
                  color: Color(0xffDFDFDF),
                ),
                InkWell(
                  onTap: () {
                    provider.deleteThread(index);
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      ImageIcon(AssetImage(
                          'assets/icon_delete_thread_bottom_sheet.png')),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Delete thread",
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

  void _buildMoreAccount() {
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
          height: 150,
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
              Row(children: [
                Image.asset('assets/icon_setting.png', height: 24, width: 24),
                const SizedBox(
                  width: 10,
                ),
                Text('Settings', style: body1Semi),
              ]),
              Divider(
                color: Color(0xffDFDFDF),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(context, login);
                },
                child: Row(children: [
                  Image.asset('assets/icon_logout.png', height: 24, width: 24),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('Logout', style: body1Semi),
                ]),
              ),
            ],
          ),
        );
      },
    );
  }
}
