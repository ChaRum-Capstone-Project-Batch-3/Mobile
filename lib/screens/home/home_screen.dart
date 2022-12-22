import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:fgd_flutter/shared/router.dart';
import 'package:provider/provider.dart';
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
