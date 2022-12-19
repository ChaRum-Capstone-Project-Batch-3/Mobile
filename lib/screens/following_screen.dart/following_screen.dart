import 'package:fgd_flutter/providers/get_user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/app_colors.dart';
import '../../shared/charum_ui.dart';
import '../../shared/styles.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({super.key});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<GetUserViewModel>(context, listen: false);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
          ),
          backgroundColor: AppColors.kcBaseWhite,
          centerTitle: true,
          title: Container(
              margin: spacing16All,
              child: Text(
                provider.user.userName ?? "",
                style: body1.copyWith(color: AppColors.kcBaseBlack),
              )),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.kcDarkWhite,
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
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      ),
                    ),
                  ),
                ),
                TabBar(
                  padding: EdgeInsets.only(left: 18, right: 18, top: 8),
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
                          Text(
                            "1",
                            style: body2.copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Together",
                            style: body2.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        children: [
                          Text(
                            "48",
                            style: body2.copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Following",
                            style: body2.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        children: [
                          Text(
                            "1204",
                            style: body2.copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Followers",
                            style: body1.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          elevation: 0.0,
        ),
        body: TabBarView(
          children: [followedWidget(), followedWidget(), followedWidget()],
        ),
      ),
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
                              backgroundImage: AssetImage('assets/1.png'),
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
                                RoundedRectangleBorder>(RoundedRectangleBorder(
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
              },
            ),
          ),
        ),
      ],
    );
  }
}
