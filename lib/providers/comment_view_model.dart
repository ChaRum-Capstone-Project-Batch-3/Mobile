import 'package:fgd_flutter/models/comment/comment_model.dart';
import 'package:fgd_flutter/models/thread/comment.dart';
import 'package:fgd_flutter/models/thread/thread.dart';
import 'package:fgd_flutter/models/thread_detail/get_thread_detail_response.dart';
import 'package:fgd_flutter/services/thread_api.dart';
import 'package:fgd_flutter/shared/local_storage.dart';
import 'package:fgd_flutter/state/comment_state.dart';
import 'package:flutter/material.dart';

class CommentViewModel with ChangeNotifier {
  var mPreferences = LocalStorage();
  CommentState _state = CommentState.loaded;
  CommentState get state => _state;
  List<Comment> _comments = [];
  List<Comment> get comments => _comments;
  TextEditingController _teComment = TextEditingController();
  TextEditingController get teComment => _teComment;
  Comment _reply = Comment();
  Comment get reply => _reply;
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
        CommentModel comment = CommentModel(
            parentID: this._reply.sId, comment: this._teComment.text);
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

  replyComment(Comment comment) {
    this._reply = comment;
    notifyListeners();
  }

  clearReply() async {
    this._reply = Comment();
    notifyListeners();
  }

  clearAll() {
    this._reply = Comment();
    this.teComment.text = "";
    notifyListeners();
  }
}
