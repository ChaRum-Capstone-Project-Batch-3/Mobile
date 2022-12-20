import 'package:fgd_flutter/providers/comment_view_model.dart';
import 'package:fgd_flutter/screens/thread_detail/widgets/add_comment.dart';
import 'package:fgd_flutter/shared/charum_ui.dart';
import 'package:fgd_flutter/shared/helper.dart';
import 'package:fgd_flutter/state/comment_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CommentBody extends StatefulWidget {
  const CommentBody({super.key});

  @override
  State<CommentBody> createState() => _CommentBodyState();
}

class _CommentBodyState extends State<CommentBody> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CommentViewModel>(context, listen: false);
    return DraggableScrollableSheet(
        snap: true,
        initialChildSize: 0.98,
        maxChildSize: 1,
        minChildSize: 0.4,
        builder: (_, controller) {
          switch (provider.state) {
            case CommentState.loading:
              return loading();
            case CommentState.error:
              return Text("ERROR");
          }
          return Container(
            decoration: BoxDecoration(
              color: AppColors.kcBaseWhite,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
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
                Center(
                  child: Text(provider.comments.length.toString() + " Comments",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: provider.comments.length,
                      itemBuilder: (context, index) {
                        var now = DateTime.now();
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (provider.comments[index].parentID ==
                                "000000000000000000000000")
                              Container(
                                padding: spacing16All,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        provider.comments[index].user!
                                                    .profilePictureURL ==
                                                ""
                                            ? CircleAvatar(
                                                radius: 20,
                                                backgroundImage:
                                                    AssetImage('assets/2.png'),
                                              )
                                            : CircleAvatar(
                                                radius: 20,
                                                backgroundImage: NetworkImage(
                                                    provider
                                                        .comments[index]
                                                        .user!
                                                        .profilePictureURL!),
                                              ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)),
                                                color: AppColors.kcDarkerWhite),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ListTile(
                                                  title: Row(
                                                    children: [
                                                      Text(
                                                        provider
                                                                .comments[index]
                                                                .user!
                                                                .displayName ??
                                                            "",
                                                        style: captionSemi,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                    ],
                                                  ),
                                                  subtitle: Text(
                                                    between(
                                                        DateTime.parse(provider
                                                                .comments[index]
                                                                .createdAt!)
                                                            .toLocal(),
                                                        now),
                                                    style: body3,
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 16,
                                                    left: 16,
                                                    right: 16,
                                                  ),
                                                  child: Text(provider
                                                          .comments[index]
                                                          .comment ??
                                                      ""),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.21),
                                      child: InkWell(
                                        onTap: () {
                                          provider.replyComment(
                                              provider.comments[index]);
                                        },
                                        child: Text(
                                          'Reply',
                                          style: captionSemi.copyWith(
                                            color: AppColors.kcLightestBlack,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            for (var i = 0; i < provider.comments.length; i++)
                              if (provider.comments[i].parentID ==
                                  provider.comments[index].sId)
                                Container(
                                  padding: spacing16All,
                                  margin: spacing24Left,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      provider.comments[i].user!
                                                  .profilePictureURL ==
                                              ""
                                          ? CircleAvatar(
                                              radius: 20,
                                              backgroundImage:
                                                  AssetImage('assets/2.png'),
                                            )
                                          : CircleAvatar(
                                              radius: 20,
                                              backgroundImage: NetworkImage(
                                                  provider.comments[i].user!
                                                      .profilePictureURL!),
                                            ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              color: AppColors.kcDarkerWhite),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ListTile(
                                                title: Row(
                                                  children: [
                                                    Text(
                                                      provider.comments[i].user!
                                                              .displayName ??
                                                          "",
                                                      style: captionSemi,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                  ],
                                                ),
                                                subtitle: Text(
                                                  between(
                                                      DateTime.parse(provider
                                                              .comments[i]
                                                              .createdAt!)
                                                          .toLocal(),
                                                      now),
                                                  style: body3,
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 16,
                                                  left: 16,
                                                  right: 16,
                                                ),
                                                child: Text(provider
                                                        .comments[i].comment ??
                                                    ""),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          ],
                        );
                      }),
                ),
                Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20.0))),
                    child: AddComment())

                /**reply kedua */
              ],
            ),
          );
        });
  }

  Widget loading() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kcBaseWhite,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      child: Shimmer.fromColors(
        baseColor: AppColors.kcLightestBlack,
        highlightColor: AppColors.kcDarkWhite,
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
            Center(
              child: Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  color: AppColors.kcLightestBlack,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: spacing16All,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.kcLightestBlack,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: AppColors.kcDarkerWhite),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: AppColors.kcLightestBlack,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                      ],
                                    ),
                                    subtitle: Container(
                                      width: 50,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: AppColors.kcLightestBlack,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      top: 10,
                                      bottom: 16,
                                      left: 16,
                                      right: 16,
                                    ),
                                    width: 100,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: AppColors.kcLightestBlack,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.21),
                        width: 70,
                        height: 30,
                        decoration: BoxDecoration(
                          color: AppColors.kcLightestBlack,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: spacing16All,
                  margin: spacing24Left,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.kcLightestBlack,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: AppColors.kcDarkerWhite),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: AppColors.kcLightestBlack,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                                subtitle: Container(
                                  width: 50,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: AppColors.kcLightestBlack,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: 10,
                                  bottom: 16,
                                  left: 16,
                                  right: 16,
                                ),
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.kcLightestBlack,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            /**reply kedua */
          ],
        ),
      ),
    );
  }
}
