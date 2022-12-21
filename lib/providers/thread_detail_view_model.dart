import 'package:fgd_flutter/models/thread/thread.dart';
import 'package:fgd_flutter/services/thread_api.dart';
import 'package:fgd_flutter/services/thread_detail_api.dart';
import 'package:fgd_flutter/shared/local_storage.dart';
import 'package:fgd_flutter/state/thread_detail_state.dart';
import 'package:flutter/material.dart';

import '../models/thread_detail/get_thread_detail_response.dart';

class ThreadDetailViewModel with ChangeNotifier {
  var mPreferences = LocalStorage();
  ThreadDetailState _state = ThreadDetailState.loaded;
  ThreadDetailState get state => _state;
  Thread _thread = Thread();
  Thread get thread => _thread;

  changeState(ThreadDetailState s) {
    this._state = s;
    notifyListeners();
  }

  initial(String id) async {
    changeState(ThreadDetailState.loading);
    try {
      var token = mPreferences.getString("token");
      await token.whenComplete(() async {
        await token.then((value) async {
          var result = ThreadDetailApi().getThread(id, value);
          await result.whenComplete(() async {
            await result.then((val) {
              if (val!.status == 200) {
                this._thread = val.data!.thread!;
                changeState(ThreadDetailState.loaded);
              } else {
                changeState(ThreadDetailState.error);
              }
            });
          });
        });
      });
      notifyListeners();
    } catch (e) {
      print(e.toString());
      changeState(ThreadDetailState.error);
    }
  }

  getThread(String id) async {
    try {
      var token = mPreferences.getString('token');
      await token.whenComplete(() async {
        await token.then((value) async {
          var resultGetThread = ThreadDetailApi().getThread(id, value);
          await resultGetThread.whenComplete(() async {
            await resultGetThread.then((value) {
              if (value!.status == 200) {
                this._thread = value.data!.thread!;
              }
            });
          });
        });
      });
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  likeThread() async {
    var token = mPreferences.getString('token');
    this._thread.isLiked = !this._thread.isLiked!;

    await token.whenComplete(() async {
      await token.then((value) async {
        var result = ThreadDetailApi().likeThread(this._thread.sId!, value);
        await result.whenComplete(() async {
          await result.then((val) async {
            // if (val.status == 201) {
            await getThread(this._thread.sId ?? "");
            notifyListeners();
            // }
          });
        });
      });
    });
  }

  unlikeThread() async {
    var token = mPreferences.getString('token');
    this._thread.isLiked = !this._thread.isLiked!;

    await token.whenComplete(() async {
      await token.then((value) async {
        await ThreadDetailApi().unlikeThread(this._thread.sId!, value);
        await getThread(this._thread.sId ?? "");
        notifyListeners();
      });
    });
  }

  followThread(String id) async {
    var token = mPreferences.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        await ThreadDetailApi().followThread(id, value);
        await getThread(id);
        notifyListeners();
      });
    });
  }

  unfollowThread(String id) async {
    var token = mPreferences.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        await ThreadDetailApi().unfollowThread(id, value);
        await getThread(id);
        notifyListeners();
      });
    });
  }

  bookmarkThread(String id) async {
    var token = mPreferences.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        await ThreadApi().bookmarkThread(id, value);
        await getThread(id);
        notifyListeners();
      });
    });
  }

  unbookmarkThread(String id) async {
    var token = mPreferences.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        await ThreadApi().unbookmarkThread(id, value);
        await getThread(id);
        notifyListeners();
      });
    });
  }
}
