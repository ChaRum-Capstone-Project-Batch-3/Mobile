import 'package:fgd_flutter/screens/create_thread/widgets/thread_label_modal.dart';
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
  bool _hasBeenPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.black,
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
            // splashColor: Colors.transparent,
            onTap: () {},
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
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
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
                    // MultiSelectDialogField(
                    //   // chipDisplay:,
                    //   items: _topics.map((e) => MultiSelectItem(e, e.name)).toList(),
                    //   listType: MultiSelectListType.CHIP,
                    //   onConfirm: (values) {
                    //     // _selectedTopics = values;
                    //   },
                    // ),
                    Row(
                      children: [
                        ElevatedButton(
                          child: Text(
                            'All',
                            style: TextStyle(
                              color:
                                  _hasBeenPressed ? Colors.white : Colors.grey,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                              color: const Color(0XFF178066),
                              width: 1,
                            ),
                            backgroundColor: _hasBeenPressed
                                ? const Color(0XFF178066)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          onPressed: () => {
                            setState(() {
                              _hasBeenPressed = !_hasBeenPressed;
                            }),
                            showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              )),
                              context: context,
                              builder: (context) {
                                return const TopicBottomModal();
                              },
                            )
                          },
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          height: 50,
                          width: 306,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              ChipButton(
                                'Business',
                              ),
                              ChipButton(
                                'Technology',
                              ),
                              ChipButton(
                                'Business',
                              ),
                              ChipButton(
                                'Technology',
                              ),
                              ChipButton(
                                'Business',
                              ),
                              ChipButton(
                                'Technology',
                              ),
                              ChipButton(
                                'Business',
                              ),
                              ChipButton(
                                'Technology',
                              ),
                            ],
                          ),
                        )
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

  Row ChipButton(name) {
    return Row(
      children: [
        ElevatedButton(
          child: Text(
            '$name',
            style: TextStyle(
              color: _hasBeenPressed ? Colors.white : Colors.grey,
            ),
          ),
          style: ElevatedButton.styleFrom(
            side: BorderSide(
              color: _hasBeenPressed ? const Color(0XFF178066) : Colors.grey,
              width: 1,
            ),
            backgroundColor:
                _hasBeenPressed ? const Color(0XFF178066) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          onPressed: () => {
            setState(() {
              _hasBeenPressed = !_hasBeenPressed;
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
