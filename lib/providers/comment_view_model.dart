import 'package:fgd_flutter/models/comment/comment_model.dart';
import 'package:fgd_flutter/models/home/home_thread_response.dart';
import 'package:fgd_flutter/models/thread/comment.dart';
import 'package:fgd_flutter/models/thread/thread.dart';
import 'package:fgd_flutter/models/thread_detail/get_thread_detail_response.dart';
import 'package:fgd_flutter/models/user/user.dart';
import 'package:fgd_flutter/services/thread_api.dart';
import 'package:fgd_flutter/services/user_api.dart';
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
  TextEditingController _teEditComment = TextEditingController();
  TextEditingController get teEditComment => _teEditComment;
  User _user = User();
  User get user => _user;

  changeState(CommentState s) {
    this._state = s;
  }

  initial(String threadId) async {
    changeState(CommentState.loading);
    var token = mPreferences.getString("token");
    try {
      await token.whenComplete(() async {
        await token.then((value) async {
          var resultUser = UserApi().getUser(value);
          var result = ThreadApi().getThreadDetail(threadId, value);
          await resultUser.whenComplete(() async {
            await resultUser.then((val) {
              this._user = val.data!.user ?? User();
            });
          });
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

  deleteComment(String commentId, String threadId) async {
    var token = mPreferences.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        var result = ThreadApi().deleteComment(commentId, value);
        await result.whenComplete(() async {
          await result.then((val) async {
            await getComment(threadId);
            notifyListeners();
          });
        });
      });
    });
  }

  updateComment(String commentId, String threadId) async {
    var token = mPreferences.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        var comment = CommentModel(comment: this._teEditComment.text);
        var result = ThreadApi().updateComment(commentId, comment, value);
        await result.whenComplete(() async {
          await result.then((val) async {
            this._teEditComment.text = "";
            await getComment(threadId);
            notifyListeners();
          });
        });
      });
    });
  }

  onEditComment(String id) {
    var comment = this._comments.firstWhere((element) => element.sId == id);
    comment.onEdit = true;
    this._teEditComment.text = comment.comment ?? "";
    notifyListeners();
  }
}
