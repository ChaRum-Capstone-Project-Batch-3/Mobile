import 'package:fgd_flutter/models/account/get_thread_user_response.dart';
import 'package:flutter/material.dart';

import '../services/user_api.dart';
import '../shared/local_storage.dart';
import '../state/user_state.dart';

class GetThreadUserViewModel with ChangeNotifier {
  var mPreferences = LocalStorage();
  UserState _state = UserState.loaded;
  UserState get state => _state;
  List<Threads> _threads = [];
  List<Threads> get threads => _threads;

  changeState(UserState s) {
    this._state = s;
  }

  initialThreads() async {
    changeState(UserState.loading);
    try {
      var token = mPreferences.getString('token');
      await token.whenComplete(() async {
        await token.then((value) async {
          var resultGetThread = UserApi().getThreadUser(value);
          await resultGetThread.whenComplete(() async {
            await resultGetThread.then((value) {
              if (value.status == 200) {
                this._threads = value.data!.threads ?? [];
                changeState(UserState.loaded);
              } else {
                changeState(UserState.error);
              }
            });
          });
        });
      });
      notifyListeners();
    } catch (e) {
      print('Error' + e.toString());
      changeState(UserState.error);
      notifyListeners();
    }
  }

  deleteThread(int index) async {
    var token = mPreferences.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        var result =
            UserApi().deleteThreadUser(this._threads[index].sId!, value);
        await result.whenComplete(() async {
          await result.then((val) async {
            if (val.status == 200) {
              await getThreads();
            }
          });
        });
      });
    });
    notifyListeners();
  }

  getThreads() async {
    var token = mPreferences.getString('token');
    await token.whenComplete(() async {
      await token.then((value) async {
        var resultGetThread = UserApi().getThreadUser(value);
        await resultGetThread.whenComplete(() async {
          await resultGetThread.then((value) {
            if (value.status == 200) {
              this._threads = value.data!.threads ?? [];
            }
          });
        });
      });
    });
    notifyListeners();
  }

  likeThread(int index) async {
    var token = mPreferences.getString("token");
    this._threads[index].isLiked = !this._threads[index].isLiked!;
    await token.whenComplete(() async {
      await token.then((value) async {
        var result = UserApi().likeThread(this._threads[index].sId!, value);
        await result.whenComplete(() async {
          await result.then((val) async {
            await getThreads();
            notifyListeners();
          });
        });
      });
    });
  }

  unlikeThread(int index) async {
    var token = mPreferences.getString("token");
    this._threads[index].isLiked = !this._threads[index].isLiked!;
    await token.whenComplete(() async {
      await token.then((value) async {
        await UserApi().unlikeThread(this._threads[index].sId!, value);
        await getThreads();
        notifyListeners();
      });
    });
  }
}
