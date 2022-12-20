import 'package:fgd_flutter/screens/thread_detail/widgets/comment_body.dart';
import 'package:fgd_flutter/shared/app_colors.dart';
import 'package:fgd_flutter/shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/thread_detail_view_model.dart';
import 'widgets/comment_screen.dart';

class ThreadDetailScreen extends StatefulWidget {
  const ThreadDetailScreen({super.key, required this.id});

  final String id;
  @override
  State<ThreadDetailScreen> createState() => _ThreadDetailScreenState();
}

class _ThreadDetailScreenState extends State<ThreadDetailScreen> {
  bool actionFollowAccount = true;
  bool actionLike = true;
  bool actionFollowThread = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    Provider.of<ThreadDetailViewModel>(context, listen: false)
        .getThread("639df35efd1cd9847a8fc4df");
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ThreadDetailViewModel>(context, listen: false)
        .getThread(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThreadDetailViewModel>(context, listen: false);
    var thread = provider.thread;
    return Consumer<ThreadDetailViewModel>(builder: (context, provider, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 83, 50, 50),
            ),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _buildSnackBarAddBookmark();
                });
              },
              child: Image.asset(
                'assets/icon_add_bookmark_bottom_sheet.png',
                height: 24,
                width: 24,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () => _buildMoreThread(),
              child: Image.asset(
                'assets/icon_more.png',
                height: 24,
                width: 24,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        body: body(provider),
        bottomNavigationBar: Container(
            decoration:
                BoxDecoration(border: Border.all(color: Color(0xffe3e3e3))),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
            height: 48,
            width: 360,
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            actionLike = !actionLike;
                          });
                        },
                        child: actionLike
                            ? Row(
                                children: [
                                  Image.asset('assets/icon_like1.png',
                                      height: 24, width: 24),
                                  const Text('401'),
                                ],
                              )
                            : Row(
                                children: [
                                  Image.asset('assets/icon_like2.png',
                                      height: 24, width: 24),
                                  const Text(
                                    '402',
                                    style:
                                        TextStyle(color: AppColors.kcInfoColor),
                                  ),
                                ],
                              )),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          _buildComment();
                        },
                        child: Row(
                          children: [
                            Image.asset('assets/icon_comment.png',
                                height: 24, width: 24),
                            const Text('2'),
                          ],
                        ))
                  ],
                ),
                Container(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            actionFollowThread = !actionFollowThread;
                          });
                        },
                        child: actionFollowThread
                            ? const Text(
                                'Follow thread',
                                style: TextStyle(
                                    color: AppColors.kcPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              )
                            : const Text(
                                'Following Thread',
                                style: TextStyle(
                                    color: AppColors.kcLightestBlack,
                                    fontWeight: FontWeight.bold),
                              )),
                  ),
                )
              ],
            )),
      );
    });
  }

  Widget body(ThreadDetailViewModel provider) {
    var provider = Provider.of<ThreadDetailViewModel>(context, listen: false);
    var thread = provider.thread;
    return Container(
      color: Color(0xfff1f3f5),
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 270, bottom: 10),
                decoration: BoxDecoration(
                  color: const Color(0xffececec),
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 15, right: 15),
                child: Text(
                  '${provider.thread.topic?.topic}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    '${provider.thread.title}',
                    style: heading3Semi,
                  )),
              _buildProfileThread(),
              _buildThreadWithImage(),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _buildProfileThread() {
    var provider = Provider.of<ThreadDetailViewModel>(context, listen: false);
    var thread = provider.thread;
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('${provider.thread.creator?.displayName}'),
          const SizedBox(
            width: 5,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            color: const Color(0xffC7C7C7),
            width: 6,
            height: 6,
            child: const CircleAvatar(
              backgroundColor: Color(0xffC7C7C7),
            ),
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                  actionFollowAccount = !actionFollowAccount;
                });
              },
              child: actionFollowAccount
                  ? const Text(
                      'Follow',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    )
                  : const Text(
                      'Following',
                      style: TextStyle(
                          color: AppColors.kcLightestBlack,
                          fontWeight: FontWeight.bold),
                    )),
        ],
      ),
      subtitle: const Text('1h ago'),
      leading: Image.asset('assets/Ellipse 42.png'),
    );
  }

  Container _buildThreadWithImage() {
    var provider = Provider.of<ThreadDetailViewModel>(context, listen: false);
    var thread = provider.thread;
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset('assets/image 1.png', width: 350),
          ),
          Text('${provider.thread.description}'),
        ],
      ),
    );
  }

  void _buildMoreThread() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Container(
          alignment: Alignment.topLeft,
          height: 250,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/pony_bottom_sheet.png',
                  width: 38,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(children: [
                Image.asset('assets/icon_follow_thread.jpeg',
                    height: 24, width: 24),
                const SizedBox(
                  width: 10,
                ),
                Text('Follow thread', style: body1Semi),
              ]),
              const Divider(
                height: 20,
                color: Color(0xffDFDFDF),
              ),
              Row(children: [
                Image.asset('assets/icon_add_bookmark_bottom_sheet.png',
                    height: 24, width: 24),
                const SizedBox(
                  width: 10,
                ),
                Text('Bookmark', style: body1Semi),
              ]),
              const Divider(
                height: 20,
                color: Color(0xffDFDFDF),
              ),
              Row(children: [
                Image.asset('assets/icon_share_bottom_sheet.png',
                    height: 24, width: 24),
                const SizedBox(
                  width: 10,
                ),
                Text('Share', style: body1Semi),
              ]),
              const Divider(
                height: 20,
                color: Color(0xffDFDFDF),
              ),
              Row(children: [
                Image.asset('assets/icon_report_bottom_sheet.png',
                    height: 24, width: 24),
                const SizedBox(
                  width: 10,
                ),
                Text('Report thread', style: body1Semi),
              ]),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }

  // ignore: unused_element
  void _buildSnackBarAddBookmark() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 500),
        backgroundColor: AppColors.kcPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 130,
            right: 20,
            left: 20),
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon_succes_add_bookmark_circle.png',
              height: 24,
              width: 24,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Thread added to your Bookmarks',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        )));
  }

  void _buildComment() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (context) {
          return CommentScreen(
            threadId: widget.id,
          );
        });
  }
}
