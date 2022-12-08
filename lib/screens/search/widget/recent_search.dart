import 'package:fgd_flutter/providers/search_thread_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fgd_flutter/shared/charum_ui.dart';
import 'package:provider/provider.dart';

class RecentSearchScreen extends StatelessWidget {
  const RecentSearchScreen({super.key, required this.recent});

  final List<String> recent;

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
                onTap: () {
                  Provider.of<SearchThreadViewModel>(context, listen: false)
                      .clearRecent();
                },
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
                itemCount: recent.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: spacing8Vertical,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BoxText.body2(recent[index]),
                        GestureDetector(
                          onTap: () {
                            Provider.of<SearchThreadViewModel>(context,
                                    listen: false)
                                .removeRecent(index);
                          },
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
