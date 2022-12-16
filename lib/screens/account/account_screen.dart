import 'package:fgd_flutter/screens/edit_account/edit_account_screen.dart';
import 'package:fgd_flutter/shared/charum_ui.dart';
import 'package:fgd_flutter/shared/router.dart';
import 'package:fgd_flutter/shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/get_user_view_model.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool actionLike = true;
  bool actionFollow = true;
  final primaryColor = AppColors.kcPrimaryColor;
  final whiteColor = AppColors.kcBaseWhite;

  @override
  void initState() {
    Provider.of<GetUserViewModel>(context, listen: false).getUsers();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetUserViewModel>(builder: (context, provider, child) {
      return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
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
                    Container(
                      height: 72,
                      width: 72,
                      child: Image.network(
                        provider.user.profilePictureURL ??
                            'assets/account_default.png',
                      ),
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
                                setState(() {
                                  actionFollow = !actionFollow;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 34, right: 34),
                                child: GestureDetector(
                                  onTap: (() {
                                    Navigator.pushNamed(context, editAccount);
                                  }),
                                  child: Text(
                                    'Edit profile',
                                    style: body2Semi,
                                  ),
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
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildPostThread(),
                      _buildPostThread(),
                    ],
                  ),
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

  Row _buildProfile() {
    return Row(
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
    );
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
            _buildProfileThread(),
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

  ListTile _buildProfileThread() {
    return ListTile(
      title: Text('Tom Cruise'),
      subtitle: Text('1h ago'),
      leading: Image.asset('assets/account_default.png'),
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
            'Is it grammatically correct to say, “I am going to go”?',
            style: body1Bold,
          ),
          Text(
              'It is technically correct but it is ambiguous. The infinitive ‘to go\' is hanging. It may be clear from the context but not as written. Consider, does it mean ‘go now\' or ‘go to the event\''),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      actionLike = !actionLike;
                    });
                  },
                  child: actionLike
                      ? Row(
                          children: [
                            Image.asset('assets/icon_like1.png',
                                height: 24, width: 24),
                            Text('592'),
                          ],
                        )
                      : Row(
                          children: [
                            Image.asset('assets/icon_like2.png',
                                height: 24, width: 24),
                            Text(
                              '592',
                              style: TextStyle(color: AppColors.kcInfoColor),
                            ),
                          ],
                        )),
              SizedBox(
                width: 10,
              ),
              Row(
                children: [
                  Image.asset('assets/icon_comment.png', height: 24, width: 24),
                  Text('108'),
                ],
              ),
            ],
          )
        ],
      ),
    );
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
              const Divider(
                height: 20,
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
