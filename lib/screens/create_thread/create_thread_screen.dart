import 'dart:io';

import 'package:fgd_flutter/models/create_thread/create_thread.dart';
import 'package:fgd_flutter/providers/create_thread_view_model.dart';
import 'package:fgd_flutter/providers/home_thread_view_model.dart';
import 'package:fgd_flutter/screens/create_thread/widgets/thread_label_modal.dart';
import 'package:fgd_flutter/shared/router.dart';
import 'package:fgd_flutter/state/create_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fgd_flutter/shared/charum_ui.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CreateThread extends StatefulWidget {
  const CreateThread({super.key});

  @override
  State<CreateThread> createState() => _CreateThreadState();
}

class _CreateThreadState extends State<CreateThread> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<CreateThreadViewModel>(context, listen: false).getTopic();
    super.initState();
  }

  final ImagePicker _picker = ImagePicker();
  File? image;
  String? topicId;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateThreadViewModel>(
      builder: (context, provider, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 1.0,
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
                onTap: () async {
                  var providerThread = Provider.of<CreateThreadViewModel>(
                      context,
                      listen: false);
                  CreateThreadBody thread = CreateThreadBody(
                    title: _titleController.text,
                    description: _contentController.text,
                    topicID: topicId,
                    imageURL: image != null ? image!.path : '',
                  );
                  var result = providerThread.createThread(thread);
                  if (providerThread.state == CreateState.loading) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          backgroundColor: Color(0xffffffff),
                          content: Container(
                            height: 250,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Lottie.asset('assets/loading.json'),
                                Text(
                                  'Please wait...',
                                  style: body1.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  await result.whenComplete(() async {
                    await result.then((value) {
                      if (providerThread.isSuccess) {
                        Provider.of<HomeThreadViewModel>(context, listen: false)
                            .init();
                        Navigator.pushNamedAndRemoveUntil(
                            context, home, (route) => false);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(milliseconds: 500),
                          backgroundColor: AppColors.kcPrimaryColor,
                          elevation: 0.0,
                          content: Row(
                            children: [
                              Image.asset(
                                'assets/icon_succes_add_bookmark_circle.png',
                                height: 24,
                                width: 24,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('Yay, your thread has been posted'),
                            ],
                          ),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.only(
                              left: 42.5, right: 42.5, top: 16, bottom: 16),
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height - 150,
                              right: 20,
                              left: 20),
                        ));
                      }
                    });
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 14.5, left: 14.5),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Post',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.kcPrimaryColor,
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
          body: Container(
            padding: spacing16All,
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 40,
                    child: TextFormField(
                      controller: _titleController,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: const InputDecoration(
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
                  SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: Container(
                      height: 474,
                      child: TextFormField(
                        controller: _contentController,
                        decoration: const InputDecoration(
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
                  Flexible(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child: ElevatedButton(
                            child: const Text(
                              'See all',
                              style: TextStyle(color: AppColors.kcPrimaryColor),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: spacing16All,
                              side: const BorderSide(
                                color: Color(0XFF178066),
                                width: 1,
                              ),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            onPressed: () => {
                              showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                )),
                                context: context,
                                builder: (context) {
                                  return TopicBottomModal();
                                },
                              )
                            },
                          ),
                        ),
                        Flexible(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.topics.length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: spacing8Left,
                                    child: ElevatedButton(
                                      child: Text(
                                        provider.topics[index].topic ?? "",
                                        style: TextStyle(
                                          color:
                                              provider.topics[index].isSelected
                                                  ? AppColors.kcBaseWhite
                                                  : AppColors.kcPrimaryColor,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        padding: spacing16All,
                                        side: BorderSide(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                        backgroundColor:
                                            provider.topics[index].isSelected
                                                ? AppColors.kcPrimaryColor
                                                : AppColors.kcBaseWhite,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        provider.setTopic(index);
                                        setState(() {
                                          topicId = provider.topics[index].sId;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
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
                  SizedBox(
                    height: 8,
                  ),
                  image != null
                      ? GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Image.file(image!),
                          ),
                        )
                      : Container(
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
                              onPressed: () {
                                getImage();
                              },
                              child: Image(
                                image: AssetImage('assets/Upload.png'),
                              )),
                        ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
  }
}
