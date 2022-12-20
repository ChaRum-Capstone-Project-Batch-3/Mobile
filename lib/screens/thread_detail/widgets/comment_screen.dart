import 'package:fgd_flutter/providers/comment_view_model.dart';
import 'package:fgd_flutter/screens/thread_detail/widgets/comment_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fgd_flutter/shared/helper.dart';

import 'add_comment.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key, required this.threadId});

  final String threadId;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<CommentViewModel>(context, listen: false)
        .initial(widget.threadId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentViewModel>(builder: (context, provider, child) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: CommentBody(),
      );
    });
  }
}
