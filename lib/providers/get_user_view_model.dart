import 'package:fgd_flutter/models/user/user.dart';
import 'package:fgd_flutter/models/home/home_thread_response.dart';
import 'package:fgd_flutter/models/thread/thread.dart';
import 'package:flutter/material.dart';

import '../models/account/get_thread_user_response.dart';
import '../services/user_api.dart';
import '../shared/local_storage.dart';
import '../state/user_state.dart';

class GetUserViewModel with ChangeNotifier {
  var mPreferences = LocalStorage();
  User _user = User();
  User get user => _user;
  UserState _state = UserState.loaded;
  UserState get state => _state;
  List<Thread> _threads = [];
  List<Thread> get threads => _threads;

  changeState(UserState s) {
    this._state = s;
  }

  getUsers() async {
    changeState(UserState.loading);
    try {
      var token = mPreferences.getString('token');
      await token.whenComplete(() async {
        await token.then((value) async {
          var resultGetUser = UserApi().getUser(value);
          await resultGetUser.whenComplete(() async {
            await resultGetUser.then((value) {
              if (value.status == 200) {
                this._user = value.data!.user!;
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
      print(e.toString());
      notifyListeners();
    }
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

  Future<bool> logout() async {
    var removeToken = mPreferences.remove("token");
    var removeStatus = mPreferences.remove("isLogin");
    await removeToken.whenComplete(() async {
      await removeToken.then((value) async {
        if (value) {
          await removeStatus.whenComplete(() async {
            await removeStatus.then((val) {
              if (val) {
                return true;
              }
            });
          });
        }
      });
    });
    return false;
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
