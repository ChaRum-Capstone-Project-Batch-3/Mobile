import 'package:fgd_flutter/models/thread/comment.dart';
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
  void dispose() {
    // TODO: implement dispose
    Provider.of<CommentViewModel>(context, listen: false)
        .teEditComment
        .dispose();
    super.dispose();
  }

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
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
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
                        final date =
                            DateTime.parse(provider.comments[index].createdAt!)
                                .toLocal();
                        final now = DateTime.now();
                        final diff = between(date, now);
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
                                          child: provider.comments[index].onEdit
                                              ? TextFormField(
                                                  controller:
                                                      provider.teEditComment,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        spacing16Horizontal,
                                                    filled: true,
                                                    fillColor:
                                                        const Color.fromARGB(
                                                            255, 232, 230, 230),
                                                    border: OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    15.0)),
                                                  ),
                                                )
                                              : Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15)),
                                                      color: AppColors
                                                          .kcDarkerWhite),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ListTile(
                                                        title: Row(
                                                          children: [
                                                            Text(
                                                              provider
                                                                      .comments[
                                                                          index]
                                                                      .user!
                                                                      .displayName ??
                                                                  "",
                                                              style:
                                                                  captionSemi,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                          ],
                                                        ),
                                                        subtitle: Text(
                                                          diff.toString(),
                                                          style: body3,
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
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
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.21,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              provider.replyComment(
                                                  provider.comments[index]);
                                            },
                                            child: Text(
                                              'Reply',
                                              style: captionSemi.copyWith(
                                                color:
                                                    AppColors.kcLightestBlack,
                                              ),
                                            ),
                                          ),
                                          if (provider
                                                  .comments[index].user!.sId ==
                                              provider.user.sId)
                                            provider.comments[index].onEdit
                                                ? InkWell(
                                                    onTap: () {
                                                      provider.updateComment(
                                                          provider
                                                                  .comments[
                                                                      index]
                                                                  .sId ??
                                                              "",
                                                          provider
                                                                  .comments[
                                                                      index]
                                                                  .threadID ??
                                                              "");
                                                    },
                                                    child: Text(
                                                      "Save",
                                                      style: button.copyWith(
                                                        color: AppColors
                                                            .kcDarkestWhite,
                                                      ),
                                                    ),
                                                  )
                                                : InkWell(
                                                    onTap: () {
                                                      other(provider
                                                          .comments[index]);
                                                    },
                                                    child: ImageIcon(
                                                      AssetImage(
                                                          "assets/icon-more-vert.png"),
                                                      size: 10,
                                                      color: AppColors
                                                          .kcLightestBlack,
                                                    ),
                                                  ),
                                        ],
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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
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
                                                    backgroundImage: AssetImage(
                                                        'assets/2.png'),
                                                  )
                                                : CircleAvatar(
                                                    radius: 20,
                                                    backgroundImage:
                                                        NetworkImage(provider
                                                            .comments[i]
                                                            .user!
                                                            .profilePictureURL!),
                                                  ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Expanded(
                                              child: provider.comments[i].onEdit
                                                  ? TextFormField(
                                                      controller: provider
                                                          .teEditComment,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            spacing16Horizontal,
                                                        filled: true,
                                                        fillColor: const Color
                                                                .fromARGB(
                                                            255, 232, 230, 230),
                                                        border: OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    width: 1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0)),
                                                      ),
                                                    )
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15)),
                                                          color: AppColors
                                                              .kcDarkerWhite),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ListTile(
                                                            title: Row(
                                                              children: [
                                                                Text(
                                                                  provider
                                                                          .comments[
                                                                              i]
                                                                          .user!
                                                                          .displayName ??
                                                                      "",
                                                                  style:
                                                                      captionSemi,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                              ],
                                                            ),
                                                            subtitle: Text(
                                                              diff,
                                                              style: body3,
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 10,
                                                              bottom: 16,
                                                              left: 16,
                                                              right: 16,
                                                            ),
                                                            child: Text(provider
                                                                    .comments[i]
                                                                    .comment ??
                                                                ""),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      if (provider.comments[i].user!.sId ==
                                          provider.user.sId)
                                        provider.comments[i].onEdit
                                            ? InkWell(
                                                onTap: () {
                                                  provider.updateComment(
                                                      provider.comments[i]
                                                              .sId ??
                                                          "",
                                                      provider.comments[i]
                                                              .threadID ??
                                                          "");
                                                },
                                                child: Text(
                                                  "Save",
                                                  style: button.copyWith(
                                                    color: AppColors
                                                        .kcDarkestWhite,
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                margin: spacing16Right,
                                                child: InkWell(
                                                  onTap: () {
                                                    other(provider.comments[i]);
                                                  },
                                                  child: ImageIcon(
                                                    AssetImage(
                                                        "assets/icon-more-vert.png"),
                                                    size: 10,
                                                    color: AppColors
                                                        .kcLightestBlack,
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
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 40,
                height: 4,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
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

  void other(Comment comment) {
    var provider = Provider.of<CommentViewModel>(context, listen: false);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        backgroundColor: AppColors.kcBaseWhite,
        builder: (BuildContext context) {
          return Container(
            height: 130,
            padding: spacing20All,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                    child: InkWell(
                  onTap: () {
                    provider.onEditComment(comment.sId ?? "");
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      ImageIcon(
                        AssetImage('assets/icon_edit_profile.png'),
                        size: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Edit Comment",
                        style: button,
                      ),
                    ],
                  ),
                )),
                const Divider(
                  height: 20,
                  color: Color(0xffDFDFDF),
                ),
                Container(
                    child: InkWell(
                  onTap: () {
                    provider.deleteComment(
                        comment.sId ?? "", comment.threadID ?? "");
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      ImageIcon(AssetImage(
                          'assets/icon_delete_thread_bottom_sheet.png')),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Remove Comment",
                        style: button,
                      ),
                    ],
                  ),
                )),
              ],
            ),
          );
        });
  }
}
