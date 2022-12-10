import 'package:flutter/material.dart';

class AddComment extends StatefulWidget {
  const AddComment({super.key});

  @override
  State<AddComment> createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  TextEditingController _addkomenController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: const Color(0xffe3e3e3))),
      padding: const EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 12),
      height: 70,
      width: 360,
      child: Stack(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const CircleAvatar(),
            ),
            SizedBox(
              width: 250,
              height: 60,
              child: TextFormField(
                controller: _addkomenController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 232, 230, 230),
                  hintText: "Add comment...",
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(25.0)),
                ),
              ),
            ),
            GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(left: 3, top: 10),
                  child: Image.asset('assets/icon_send.jpeg',
                      height: 24, width: 24),
                ))
          ],
        )
      ]),
    );
  }
}
