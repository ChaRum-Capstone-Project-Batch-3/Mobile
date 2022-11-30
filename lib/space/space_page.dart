import 'package:flutter/material.dart';

import '../shared/app_colors.dart';
import '../shared/styles.dart';

class SpacePage extends StatefulWidget {
  SpacePage({super.key});

  @override
  State<SpacePage> createState() => _SpacePageState();
}

class _SpacePageState extends State<SpacePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
                'Space',
                style: heading3Bold.copyWith(color: AppColors.kcPrimaryColor),
              ),
        backgroundColor: Colors.white,
        actions: [
          Row(
            children: [
              InkWell(child: Image.asset("assets/notification.png")),
              SizedBox(width: 15),
              InkWell(
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Space',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
