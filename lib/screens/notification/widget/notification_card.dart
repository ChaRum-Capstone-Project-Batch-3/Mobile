import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
          child: Text("Today"),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                  height: 81,
                  // color: Colors.white,
                  child: Container(
                    margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(300),
                          child: Image.asset(
                            "assets/fake_thread.png",
                            width: 32,
                            height: 32,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: 300,
                                child: Text(
                                    "Hey, you have a new comment on Ade Winda’s thread.",
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis)),
                            SizedBox(
                              height: 2,
                            ),
                            Text("1m ago")
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
