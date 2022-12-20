import 'package:fgd_flutter/models/comment/comment.dart';
import 'package:fgd_flutter/models/thread_detail/get_thread_detail_response.dart';
import 'package:fgd_flutter/services/thread_api.dart';
import 'package:fgd_flutter/shared/local_storage.dart';
import 'package:fgd_flutter/state/comment_state.dart';
import 'package:flutter/material.dart';

class CommentViewModel with ChangeNotifier {
  var mPreferences = LocalStorage();
  CommentState _state = CommentState.loaded;
  CommentState get state => _state;
  List<Comments> _comments = [];
  List<Comments> get comments => _comments;
  TextEditingController _teComment = TextEditingController();
  TextEditingController get teComment => _teComment;
  Comments _reply = Comments();
  Comments get reply => _reply;
  Thread _thread = Thread();
  Thread get thread => _thread;

  changeState(CommentState s) {
    this._state = s;
  }

  initial(String threadId) async {
    changeState(CommentState.loading);
    var token = mPreferences.getString("token");
    try {
      await token.whenComplete(() async {
        await token.then((value) async {
          var result = ThreadApi().getThreadDetail(threadId, value);
          await result.whenComplete(() async {
            await result.then((val) {
              if (val.status == 200) {
                this._comments = val.data!.comments ?? [];
                this._thread = val.data!.thread ?? Thread();
                changeState(CommentState.loaded);
              } else {
                changeState(CommentState.error);
              }
            });
          });
        });
      });
      notifyListeners();
    } catch (e) {
      changeState(CommentState.error);
      notifyListeners();
    }
  }

  getComment(String threadId) async {
    var token = mPreferences.getString("token");
    try {
      await token.whenComplete(() async {
        await token.then((value) async {
          var result = ThreadApi().getThreadDetail(threadId, value);
          await result.whenComplete(() async {
            await result.then((val) {
              if (val.status == 200) {
                this._comments = val.data!.comments ?? [];
              }
            });
          });
        });
      });
      notifyListeners();
    } catch (e) {
      print(e.toString());
      changeState(CommentState.error);
      notifyListeners();
    }
  }

  addComment(String threadId) async {
    var token = mPreferences.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        Comment comment =
            Comment(parentID: this._reply.sId, comment: this._teComment.text);
        var result = ThreadApi().addComment(threadId, comment, value);
        await result.whenComplete(() async {
          await result.then((val) {
            if (val.status == 200) {
              getComment(threadId);
              clearAll();
            }
          });
        });
      });
    });
    notifyListeners();
  }

  replyComment(Comments comment) {
    this._reply = comment;
    notifyListeners();
  }

  clearReply() async {
    this._reply = Comments();
    notifyListeners();
  }

  clearAll() {
    this._reply = Comments();
    this.teComment.text = "";
    notifyListeners();
  }
}
