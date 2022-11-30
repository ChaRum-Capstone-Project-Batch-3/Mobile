import 'package:fgd/account/account_page.dart';
import 'package:fgd/bookmark/bookmark_page.dart';
import 'package:fgd/Home/home_page.dart';
import 'package:fgd/space/space_page.dart';

import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  static List<Widget> _pages = <Widget>[
    const HomePage(),
    SpacePage(),
    const BookmarkScreen(),
    const AccountScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon_home1.png',
              height: 24,
              width: 24,
            ),
            activeIcon: Image.asset(
              'assets/icon_home2.png',
              height: 24,
              width: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon_space1.png',
              height: 24,
              width: 24,
            ),
            activeIcon: Image.asset(
              'assets/icon_space2.png',
              height: 24,
              width: 24,
            ),
            label: 'Space',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon_bookmark1.png',
              height: 24,
              width: 24,
            ),
            activeIcon: Image.asset(
              'assets/icon_bookmark2.png',
              height: 24,
              width: 24,
            ),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon_account1.png',
              height: 24,
              width: 24,
            ),
            activeIcon: Image.asset(
              'assets/icon_account2.png',
              height: 24,
              width: 24,
            ),
            label: 'Account',
          ),
        ],
        onTap: onItemTapped,
        currentIndex: selectedIndex,
        showSelectedLabels: true,
      ),
    );
  }
}
