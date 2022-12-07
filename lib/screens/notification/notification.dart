import 'package:fgd/notification/notification_card.dart';
import 'package:fgd/notification/notification_recent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          "Notification",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        titleTextStyle: const TextStyle(color: Colors.black),
      ),
      body: SingleChildScrollView(child: Column(
        children: [
          NotificationCard(),
          NotificationRecent()
        ],
      )),
    );
  }
}
