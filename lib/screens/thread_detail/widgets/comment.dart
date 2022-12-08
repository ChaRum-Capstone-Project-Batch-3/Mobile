import 'package:flutter/material.dart';

import 'add_comment.dart';

class Comment extends StatelessWidget {
  const Comment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Image.asset(
                'assets/pony_bottom_sheet.png',
                width: 40,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text("2 Comments",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/fake_profile.png'),
                ),
                const SizedBox(
                  width: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  child: Container(
                    width: 270,
                    height: 195,
                    color: Color.fromARGB(255, 232, 230, 230),
                    child: Column(
                      children: [
                        ListTile(
                          title: Row(
                            children: const [
                              Text(
                                "Ryan Reynold",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                          subtitle: const Text("20m ago"),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                              "Your posts are very interesting, thanks and btw i respect you because you are not like some other people here in quora who claims are East Asian people like Koreans and Mongolians, they are total different, Turks were Eurasian people but pre-dominantly west Eurasian"),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 160, top: 10),
              child: InkWell(
                onTap: () {},
                child: const Text(
                  'Reply',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Color.fromARGB(255, 98, 98, 98)),
                ),
              ),
            ),

            /**reply kedua */
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                margin: const EdgeInsets.only(left: 40, top: 1),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          const CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage('assets/Ellipse 42.png')),
                          const SizedBox(
                            width: 10,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                            child: Container(
                              width: 210,
                              height: 100,
                              color: Color.fromARGB(255, 232, 230, 230),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Row(
                                      children: const [
                                        Text(
                                          "Livy Renata",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                      ],
                                    ),
                                    subtitle: const Text("20m ago"),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 50),
                                    child: Text("Yeah, I agree with you"),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 90, top: 10),
                        child: InkWell(
                          onTap: () {},
                          child: const Text(
                            'Reply',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Color.fromARGB(255, 98, 98, 98)),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AddComment(),
    );
  }
}
