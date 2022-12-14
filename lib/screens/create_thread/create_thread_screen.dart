import 'package:fgd_flutter/screens/create_thread/widgets/thread_label_modal.dart';
import 'package:fgd_flutter/shared/router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

class Topic {
  Topic({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;
}

class CreateThread extends StatefulWidget {
  const CreateThread({super.key});

  @override
  State<CreateThread> createState() => _CreateThreadState();
}

class _CreateThreadState extends State<CreateThread> {
  int countBoolList(List<bool> _topicStatus) {
    int count = 0;
    for (int i = 0; i < _topicStatus.length; i++) {
      if (_topicStatus.elementAt(i) == true) {
        count++;
      }
    }
    return count;
  }

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
    false
  ];

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (() => Navigator.pop(context)),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Create Thread',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          InkWell(
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.pushNamed(context, home);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Post',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                // key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      child: const TextField(
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Add an interesting title',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 474,
                      child: const TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write something...',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 12),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Choose a topic',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          child: Text(
                            'All',
                            style: TextStyle(
                              color:
                                  _topicStatus[0] ? Colors.white : Colors.grey,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                              color: const Color(0XFF178066),
                              width: 1,
                            ),
                            backgroundColor: _topicStatus[0]
                                ? const Color(0XFF178066)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          onPressed: () => {
                            setState(() {
                              _topicStatus[0] = !_topicStatus[0];
                            }),
                            showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              )),
                              context: context,
                              builder: (context) {
                                List<bool> topicStatus = _topicStatus;
                                return TopicBottomModal(
                                  topicStatus: [],
                                );
                              },
                            )
                          },
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        ChipButton('Business', 1),
                        ChipButton('Technology', 2),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 12),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Add image',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          side: const BorderSide(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: () {},
                        child: const Image(
                          image: AssetImage('assets/Upload.png'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ))),
    );
  }

  // _getFromGallery() async {
  //   PickedFile? pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     setState(() {
  //       imageFile = File(pickedFile.path);
  //     });
  //   }
  // }

  Row ChipButton(name, iter) {
    return Row(
      children: [
        ElevatedButton(
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
        ),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }
}
