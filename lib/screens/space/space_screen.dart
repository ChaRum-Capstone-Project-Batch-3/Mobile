import 'package:fgd_flutter/providers/get_alltopics_view_model.dart';

import 'package:fgd_flutter/shared/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/app_colors.dart';
import '../../shared/charum_ui.dart';
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

  TextEditingController searchSp = TextEditingController();
  @override
  void dispose() {
    searchSp.dispose();
    // TODO: implement dispose
    super.dispose();
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
                        buildFilterSpace();
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
                    itemBuilder: (context, index) {
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
                            mainAxisSize: MainAxisSize.min,
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

  void buildFilterSpace() {
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
          height: 280,
          // padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                width: 40,
                height: 4,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Sort',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 30,
              ),
              Wrap(
                  // clipBehavior: Clip.hardEdge,
                  // runSpacing: 3.0,
                  // spacing: 2.0,
                  alignment: WrapAlignment.start,
                  children: [
                    ChipButton('A - Z', 1),
                    SizedBox(
                      width: 5,
                    ),
                    ChipButton('Z - A', 2),
                    SizedBox(
                      width: 5,
                    ),
                    ChipButton('Last Updated', 3),
                    SizedBox(
                      width: 5,
                    ),
                    ChipButton('Most Threads', 3),
                    SizedBox(
                      width: 5,
                    ),
                    ChipButton('Latest Thread', 4)
                  ]),
              Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Confirm',
                    style: body2Semi,
                  ),
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
      onPressed: () {
        setState(() {
          _topicStatus[iter] = !_topicStatus[iter];
        });
      },
    );
  }
}
