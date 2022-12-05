import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fgd_flutter/shared/charum_ui.dart';

class RecentSearchScreen extends StatelessWidget {
  const RecentSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: spacing16All,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BoxText.subtitle1Semi("Recent"),
              GestureDetector(
                child: BoxText.caption('Clear All'),
              )
            ],
          ),
          SizedBox(
            height: 24,
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Container(
                    padding: spacing8Vertical,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BoxText.body2("Chris Evan"),
                        GestureDetector(
                          child: Icon(Icons.clear_rounded),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
