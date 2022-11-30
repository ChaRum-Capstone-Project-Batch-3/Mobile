import 'package:fgd_flutter/screens/account/account_screen.dart';
import 'package:fgd_flutter/screens/bookmark/bookmark_screen.dart';
import 'package:fgd_flutter/shared/app_colors.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  final widgetOptions = [
    const Text('Home Screen'),
    const Text('Space Screen'),
    BookmarkScreen(),
    AccountScreen(),
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
        child: widgetOptions.elementAt(selectedIndex),
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
      ),
    );
  }
}
