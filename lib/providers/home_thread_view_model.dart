import 'package:fgd_flutter/models/home/home_thread_response.dart';
import 'package:fgd_flutter/services/home_thread_api.dart';
import 'package:fgd_flutter/shared/local_storage.dart';
import 'package:flutter/material.dart';

class HomeThreadViewModel with ChangeNotifier {
  var mPreferences = LocalStorage();
  List<String> _allThread = [];
  List<String> get allThread => _allThread;
  List<Threads> _popularThread = [];
  List<Threads> get popularThread => _popularThread;
  List<Threads> _followedThread = [];
  List<Threads> get followedThread => _followedThread;

  // changeState(HomeThreadState s) {
  //   _state = s;
  //   notifyListeners();
  // }

  showAllThread() async {
    var token = mPreferences.getString('token');
    await token.whenComplete(() async {
      await token.then((value) async {
        var data = HomeThreadAPI().show("created_at", "desc", "", "", value);
        await data.whenComplete(() async {
          await data.then((value) {
            // _thread = value.threads;
            // _popular = value.popular;
            notifyListeners();
          });
        });
      });
    });
  }

  showPopularThread() {
    var token = mPreferences.getString('token');
    token.whenComplete(() async {
      await token.then((value) async {
        var data = HomeThreadAPI().show("created_at", "desc", "", "", value);
        await data.whenComplete(() async {
          await data.then((value) {
            // _popular = value.popular;
            notifyListeners();
          });
        });
      });
    });
  }

  showFollowdedThread() {
    var token = mPreferences.getString('token');
    token.whenComplete(() async {
      await token.then((value) async {
        var data = HomeThreadAPI().show("created_at", "desc", "", "", value);
        await data.whenComplete(() async {
          await data.then((value) {
            // _thread = value.threads;
            notifyListeners();
          });
        });
      });
    });
  }
}

          // var resultThread =
          //     ThreadApi().search('updatedAt', 'desc', "", search, value);
          // var resultPopular =
          //     ThreadApi().search("likes", "desc", "", search, value);
