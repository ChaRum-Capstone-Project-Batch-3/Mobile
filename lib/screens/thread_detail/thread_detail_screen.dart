import 'package:fgd_flutter/shared/app_colors.dart';
import 'package:fgd_flutter/shared/styles.dart';
import 'package:flutter/material.dart';

import 'widgets/comment.dart';

class ThreadDetailScreen extends StatefulWidget {
  const ThreadDetailScreen({super.key});

  @override
  State<ThreadDetailScreen> createState() => _ThreadDetailScreenState();
}

class _ThreadDetailScreenState extends State<ThreadDetailScreen> {
  bool actionFollowAccount = true;
  bool actionLike = true;
  bool actionFollowThread = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
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
      body: Container(
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
                  child: const Text(
                    'History',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      'What are the differences between the ancient Turks, the proto-Turks, and the modern Turks?',
                      style: heading3Bold,
                    )),
                _buildProfileThread(),
                _buildThreadWithImage(),
              ],
            ),
          ),
        ),
      ),
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
                        setState(() {
                          _buildComment();
                        });
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
  }

  ListTile _buildProfileThread() {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text('Ade Winda'),
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
          const Text(
              'Early proto-Turks, Aldy-Bel and Sagly-Uyuk culture in Southern Siberia, Scytho-Siberian. The ANE are also argued to have harbored the genes for blonde hair at high frequency, therefore several Siberian groups have light hair as well. Ancient DNA analysis (ADNA) has revealed that the oldest fossil known to carry the derived KITLG allele, which is responsible for blond hair in modern Europeans, is a 17,000 year old Ancient North Eurasian specimen from southern Siberia. Therefore the description of early Turks by Chinese chronics do not necessarily mean admixture with Iranian pastoralists, but the widespread layer of these phenotypes among Ancient Siberians. Chinese histories describe the early Turks (Tujue or Tüküe) as “mixed barbarians” having a noteworthy frequency of blonde to brown hair and blue or green eyes. The Tang historian Yan Shigu described them as "blue-eyed and red bearded". The ruling clan of the Turks, the Ashina, the tribe which first used the term “Türk”, were described'),
          const Text(
              'by Chinese authors as having an unusual appearance. According to Chinese scientist Xue Zongzheng, the early Turks had physical features that were quite different from those of East Asian people. These would include deep eye sockets, prominent noses, and light eye or hair color. However, over time, Turkic tribes intermarried with Chinese and Mongol groups, which shifted their physical appearance to a more East Asian one. This also'),
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        backgroundColor: Colors.white,
        context: context,
        // ignore: dead_code
        builder: (BuildContext context) {
          return const Comment();
        });
  }
}
