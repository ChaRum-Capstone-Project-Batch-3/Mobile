import 'package:fgd_flutter/models/home/followed_thread_response.dart';
import 'package:fgd_flutter/models/home/home_thread_response.dart';
import 'package:fgd_flutter/services/home_thread_api.dart';
import 'package:fgd_flutter/shared/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:fgd_flutter/models/thread/thread.dart';

import '../services/thread_api.dart';
import '../state/home_thread_state.dart';

class HomeThreadViewModel with ChangeNotifier {
  var mPreferences = LocalStorage();
  HomeThreadState _state = HomeThreadState.loaded;
  HomeThreadState get state => _state;
  List<Thread> _allThread = [];
  List<Thread> get allThread => _allThread;
  List<Thread> _popularThread = [];
  List<Thread> get popularThread => _popularThread;
  List<FollowThreads> _followedThread = [];
  List<FollowThreads> get followedThread => _followedThread;

  changeState(HomeThreadState s) {
    _state = s;
  }

  init() async {
    changeState(HomeThreadState.loading);
    try {
      await getThread();
      await getPopular();
      await getFollow();
      changeState(HomeThreadState.loaded);
      notifyListeners();
    } catch (e) {
      print(e.toString());
      changeState(HomeThreadState.error);
      notifyListeners();
    }
  }

  getThread() async {
    try {
      var token = mPreferences.getString("token");
      await token.whenComplete(() async {
        await token.then((value) async {
          var result = ThreadApi().search("createdAt", "desc", "", "", value);
          await result.whenComplete(() async {
            await result.then((val) {
              if (val!.status == 200) {
                this._allThread = val.data!.threads ?? [];
                notifyListeners();
              }
            });
          });
        });
      });
    } catch (e) {
      print(e.toString());
      changeState(HomeThreadState.error);
      notifyListeners();
    }
  }

  getPopular() async {
    try {
      var token = mPreferences.getString("token");
      await token.whenComplete(() async {
        await token.then((value) async {
          var result = ThreadApi().search("likes", "desc", "", "", value);
          await result.whenComplete(() async {
            await result.then((val) {
              if (val!.status == 200) {
                this._popularThread = val.data!.threads ?? [];
                print(this._popularThread[0].title);
                notifyListeners();
              }
            });
          });
        });
      });
    } catch (e) {
      print(e.toString());
      changeState(HomeThreadState.error);
      notifyListeners();
    }
  }

  getFollow() async {
    try {
      var token = mPreferences.getString("token");
      await token.whenComplete(() async {
        await token.then((value) async {
          var result = ThreadApi().getFollowThread(value);
          await result.whenComplete(() async {
            await result.then((value) {
              if (value.status == 200) {
                this._followedThread = value.data!.followThreads ?? [];
                notifyListeners();
              }
            });
          });
        });
      });
    } catch (e) {
      print(e.toString());
      changeState(HomeThreadState.error);
      notifyListeners();
    }
  }

  likeThread(int index, String type) async {
    var token = mPreferences.getString("token");
    if (type == "thread") {
      this._allThread[index].isLiked = !this._allThread[index].isLiked!;
      notifyListeners();
      await token.whenComplete(() async {
        await token.then((value) async {
          await ThreadApi().likeThread(this._allThread[index].sId!, value);
        });
      });
    } else if (type == "followed") {
      this._followedThread[index].thread!.isLiked = true;
      notifyListeners();
      await token.whenComplete(() async {
        await token.then((value) async {
          await ThreadApi()
              .likeThread(this._followedThread[index].thread!.sId!, value);
        });
      });
    } else {
      this._popularThread[index].isLiked = !this._popularThread[index].isLiked!;
      notifyListeners();
      await token.whenComplete(() async {
        await token.then((value) async {
          await ThreadApi().likeThread(this._popularThread[index].sId!, value);
        });
      });
    }
    await getPopular();
    await getThread();
    await getFollow();
    notifyListeners();
  }

  unlikeThread(int index, String type) async {
    var token = mPreferences.getString("token");
    if (type == "thread") {
      this._allThread[index].isLiked = !this._allThread[index].isLiked!;
      await token.whenComplete(() async {
        await token.then((value) async {
          await ThreadApi().unlikeThread(this._allThread[index].sId!, value);
        });
      });
    } else if (type == "followed") {
      this._followedThread[index].thread!.isLiked = true;
      notifyListeners();
      await token.whenComplete(() async {
        await token.then((value) async {
          await ThreadApi()
              .unlikeThread(this._followedThread[index].thread!.sId!, value);
        });
      });
    } else {
      this._popularThread[index].isLiked = !this._popularThread[index].isLiked!;
      await token.whenComplete(() async {
        await token.then((value) async {
          await ThreadApi()
              .unlikeThread(this._popularThread[index].sId!, value);
        });
      });
    }
    await getPopular();
    await getThread();
    await getFollow();
    notifyListeners();
  }

  followThread(String id) async {
    var token = mPreferences.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        await ThreadApi().followThread(id, value);
        await getThread();
        await getPopular();
        await getFollow();
        notifyListeners();
      });
    });
  }

  unfollowThread(String id) async {
    var token = mPreferences.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        await ThreadApi().unfollowThread(id, value);
        await getPopular();
        await getThread();
        await getFollow();
        notifyListeners();
      });
    });
  }

  bookmarkThread(String id) async {
    var token = mPreferences.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        await ThreadApi().bookmarkThread(id, value);
        await getThread();
        await getPopular();
        await getFollow();
        notifyListeners();
      });
    });
  }

  unbookmarkThread(String id) async {
    var token = mPreferences.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        await ThreadApi().unbookmarkThread(id, value);
        await getThread();
        await getPopular();
        await getFollow();
        notifyListeners();
      });
    });
  }
}
