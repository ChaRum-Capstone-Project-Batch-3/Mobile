import 'package:fgd_flutter/models/home/home_thread_response.dart';
import 'package:fgd_flutter/services/home_thread_api.dart';
import 'package:fgd_flutter/shared/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:fgd_flutter/models/thread/thread.dart';

class HomeThreadViewModel with ChangeNotifier {
  var mPreferences = LocalStorage();
  List<String> _allThread = [];
  List<String> get allThread => _allThread;
  List<Threads> _popularThread = [];
  List<Threads> get popularThread => _popularThread;
  List<Threads> _followedThread = [];
  List<Threads> get followedThread => _followedThread;

  getAllThread() async {
    var token = mPreferences.getString('token');
    await token.whenComplete(() async {
      await token.then((value) async {
        var data = HomeThreadAPI().show("created_at", "desc", "", "", value);
        await data.whenComplete(() async {
          await data.then((value) {
              if (value!.status == 200) {
                // this._allThread = value.data!.threads!.map((e) => e.id).toList();
                notifyListeners();
              }
          });
        });
      });
    });
  }

  getPopularThread() async {
    var token = mPreferences.getString('token');
    await token.whenComplete(() async {
      await token.then((value) async {
        var data = HomeThreadAPI().show("likes", "desc", "", "", value);
        await data.whenComplete(() async {
          await data.then((value) {
              if (value!.status == 200) {
                // this._popularThread = value.data!.threads!.map((e) => e.id).toList();
                notifyListeners();
              }
          });
        });
      });
    });
  }

  // getFollowdedThread() {
  //   var token = mPreferences.getString('token');
  //   token.whenComplete(() async {
  //     await token.then((value) async {
  //       var data = HomeThreadAPI().show("created_at", "desc", "", "", value);
  //       await data.whenComplete(() async {
  //         await data.then((value) {
  //           // _thread = value.threads;
  //           notifyListeners();
  //         });
  //       });
  //     });
  //   });
  // }

  likeThread(int index, String type) async {
    var token = mPreferences.getString('token');
    if (type == "thread") {
      this._allThread[index].isLiked = "liked"; = !this._allThread[index].isliked!;
      await token.whenComplete(() async {
        await token.then((value) async {
          var data = HomeThreadAPI().likeThread(this._allThread[index].id, value);
        });
      });
    } else {
      this._popularThread[index].isLiked = !this._popularThread[index].isLiked!;
      await token.whenComplete(() async {
        await token.then((value) async {
          await HomeThreadAPI().likeThread(this._popularThread[index].sId!, value);
        });
      });
    }
    await getPopularThread();
    await getAllThread();
    notifyListeners();
  }

  unlikeThread(int index, String type) async {
    var token = mPreferences.getString('token');
    if (type == "thread") {
      this._allThread[index].isLiked = !this._allThread[index].isLiked!;
      await token.whenComplete(() async {
        await token.then((value) async {
          await HomeThreadAPI().unlikeThread(this._allThread[index].sId!, value);
        });
      });
    } else {
      this._popularThread[index].isLiked = !this._popularThread[index].isLiked!;
      await token.whenComplete(() async {
        await token.then((value) async {
          await HomeThreadAPI().unlikeThread(this._popularThread[index].sId!, value);
        });
      });
    }
    await getPopularThread();
    await getAllThread();
    notifyListeners();
  }

  followThread(String id) async {
    var token = mPreferences.getString('token');
    await token.whenComplete(() async {
      await token.then((value) async {
        await HomeThreadAPI().followThread(id, value);
        await getAllThread();
        await getPopularThread();
        notifyListeners();
      });
    });
  }

  unfollowThread(String id) async {
    var token = mPreferences.getString('token');
    await token.whenComplete(() async {
      await token.then((value) async {
        await HomeThreadAPI().unfollowThread(id, value);
        await getPopularThread();
        await getAllThread();
        notifyListeners();
      });
    });
  }

  bookmarkThread(String id) async {
    var token = mPreferences.getString('token');
    await token.whenComplete(() async {
      await token.then((value) async {
        await HomeThreadAPI().bookmarkThread(id, value);
        await getAllThread();
        await getPopularThread();
        notifyListeners();
      });
    });
  }

  unbookmarkThread(String id) async {
    var token = mPreferences.getString('token');
    await token.whenComplete(() async {
      await token.then((value) async {
        await HomeThreadAPI().unbookmarkThread(id, value);
        await getAllThread();
        await getPopularThread();
        notifyListeners();
      });
    });
  }
}
