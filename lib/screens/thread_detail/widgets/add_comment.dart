import 'package:fgd_flutter/providers/comment_view_model.dart';
import 'package:fgd_flutter/shared/charum_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddComment extends StatefulWidget {
  const AddComment({super.key});

  @override
  State<AddComment> createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment>
    with SingleTickerProviderStateMixin {
  late Animation offset;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    var provider = Provider.of<CommentViewModel>(context, listen: false);
    provider.teComment.text = "";
    provider.clearReply();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Provider.of<CommentViewModel>(context, listen: false).teComment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CommentViewModel>(context, listen: false);
    return Container(
      color: AppColors.kcBaseWhite,
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: const Color(0xffe3e3e3))),
        padding: const EdgeInsets.only(left: 15, right: 15),
        // height: provider.reply.sId == null
        //     ? MediaQuery.of(context).size.height * 0.11
        //     : MediaQuery.of(context).size.height * 0.19,
        width: 360,
        child: Column(children: [
          if (provider.reply.sId == null)
            Container()
          else
            Container(
              padding: spacing8Top,
              margin: EdgeInsets.zero,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.reply_outlined),
                  Text("Reply comment from " +
                      provider.reply.user!.displayName!),
                  IconButton(
                      onPressed: () {
                        provider.clearReply();
                      },
                      icon: Icon(Icons.close))
                ],
              ),
            ),
          Container(
            padding: spacing8Vertical,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 60,
                  child: TextFormField(
                    controller: provider.teComment,
                    decoration: InputDecoration(
                      contentPadding: spacing16Horizontal,
                      filled: true,
                      fillColor: const Color.fromARGB(255, 232, 230, 230),
                      hintText: "Add comment...",
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(25.0)),
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      provider.addComment(provider.thread.sId ?? "");
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 3, top: 10),
                      child: Image.asset('assets/icon_send.jpeg',
                          height: 24, width: 24),
                    ))
              ],
            ),
          )
        ]),
      ),
    );
  }
}
