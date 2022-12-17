import 'package:fgd_flutter/models/space/space.dart';
import 'package:fgd_flutter/providers/get_alltopics_view_model.dart';
import 'package:fgd_flutter/screens/DetailSpace/detail_space.dart';
import 'package:fgd_flutter/shared/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/app_colors.dart';
import '../../shared/styles.dart';

class SpaceScreen extends StatefulWidget {
  const SpaceScreen({super.key});

  @override
  State<SpaceScreen> createState() => _SpaceScreenState();
}

class _SpaceScreenState extends State<SpaceScreen> {
  @override
  void initState() {
    print("test");
    Provider.of<AllTopicsViewModel>(context, listen: false).getAllTopics(
      "createdAt",
      "desc",
      "",
      "",
    );
    // TODO: implement initState
    super.initState();
  }

  bool actionSort = true;
  List<bool> _topicStatus = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  TextEditingController searchSp = TextEditingController();
  @override
  void dispose() {
    searchSp.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AllTopicsViewModel>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 120,
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 12.5, bottom: 12.5),
                  child: Text(
                    'Space',
                    style:
                        heading3Bold.copyWith(color: AppColors.kcPrimaryColor),
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: searchSp,
                        onEditingComplete: () {
                          value.searchTopic(searchSp.text);
                          FocusScope.of(context).unfocus();
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.kcDarkWhite,
                          hintText: "Search space",
                          prefixIcon: Container(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 20, right: 10),
                            child: Image.asset(
                              height: 24,
                              width: 24,
                              'assets/icon_search_normal.png',
                            ),
                          ),
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        buildeFilterSpace();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 8, right: 8),
                        child: Image.asset(
                          height: 24,
                          width: 24,
                          'assets/icon_filter_search.png',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Color(0xfff1f3f5),
              child: InkWell(
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    // scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 410,
                      childAspectRatio: 2 / 3.2,
                    ),
                    itemCount: value.topics.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, detailSpace,
                              arguments: value.topics[index].sId);
                        },
                        child: Container(
                          margin: EdgeInsets.all(16),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.all(20),
                                  child: Image.network(
                                      value.topics[index].imageURL ?? "")),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${value.topics[index].topic}',
                                  style: body1.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                '${value.topics[index].description}',
                                style: body1.copyWith(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                              // Align(
                              //   alignment: Alignment.centerLeft,
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(8),
                              //         color: Color(0xfff1f3f5)),
                              //     padding: EdgeInsets.only(
                              //         top: 8, right: 12, bottom: 8, left: 12),
                              //     child: Text(
                              //       '${spaces[index].sumThread}',
                              //       style: body1.copyWith(
                              //           color: Colors.grey,
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
        );
      },
    );
  }

  void buildeFilterSpace() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image.asset(
                  'assets/pony_bottom_sheet.png',
                  width: 38,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Sort',
                  style: body1Semi,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  ChipButton('A - Z', 1),
                  SizedBox(
                    width: 8,
                  ),
                  ChipButton('Z - A', 2),
                  SizedBox(
                    width: 8,
                  ),
                  ChipButton('Last Updated', 3),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  ChipButton('Most Threads', 3),
                  SizedBox(
                    width: 8,
                  ),
                  ChipButton('Latest Thread', 4),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Confirm',
                  style: body2Semi,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ElevatedButton ChipButton(name, iter) {
    return ElevatedButton(
      child: Text(
        '$name',
        style: TextStyle(
          color: _topicStatus[iter] ? Colors.white : Colors.grey,
        ),
      ),
      style: ElevatedButton.styleFrom(
        side: BorderSide(
          color: _topicStatus[iter] ? const Color(0XFF178066) : Colors.grey,
          width: 1,
        ),
        backgroundColor:
            _topicStatus[iter] ? const Color(0XFF178066) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      onPressed: () => {
        setState(() {
          _topicStatus[iter] = !_topicStatus[iter];
        })
      },
    );
  }
}
