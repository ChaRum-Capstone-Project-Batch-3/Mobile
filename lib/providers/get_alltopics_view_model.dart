

import 'package:fgd_flutter/services/thread_api.dart';

import 'package:fgd_flutter/shared/local_storage.dart';
import 'package:fgd_flutter/state/space_state.dart';
import 'package:flutter/cupertino.dart';


import '../models/thread/thread.dart';
import '../models/topic/topic.dart';
import '../services/get_alltopic_api.dart';

class AllTopicsViewModel with ChangeNotifier {
  var mPrefenreces = LocalStorage();
  List<Topic> _topics = [];
  List<Topic> get topics => _topics;
  Topic _topic = Topic();
  Topic get topic => _topic;
  List<Thread> _threads = [];
  List<Thread> get threads => _threads;
  SpaceState _state = SpaceState.loaded;
  SpaceState get state => _state;

  changeState(SpaceState f) {
    this._state = f;
  }

  searchTopic(String topic) async {
    var token = mPrefenreces.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        var result =
            GetTopicsApi().topics("createdAt", "desc", topic, "", value);
        await result.whenComplete(() async {
          await result.then((value) {
            this._topics = value!.data!.topics ?? [];
          });
        });
      });
    });
    notifyListeners();
  }

  getAllTopics(
    String sort,
    String order,
    String topic,
    String title,
  ) async {
    changeState(SpaceState.loading);
    try {
      var token = mPrefenreces.getString("token");
      await token.whenComplete(() async {
        await token.then((value) async {
          var result = GetTopicsApi().topics(sort, order, topic, title, value);
          await result.whenComplete(() async {
            await result.then((value) {
              if (value?.status == 200) {
                // this._bookmarks = val.data!.bookmarks ?? [];
                this._topics = value!.data!.topics ?? [];
                changeState(SpaceState.loaded);
              } else {
                changeState(SpaceState.error);
              }
            });
          });
        });
      });
    } catch (e) {}
    notifyListeners();
  }

  topicDetail(String Id) async {
    var token = mPrefenreces.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        var result = GetTopicsApi().detailTopics(Id, value);
        await result.whenComplete(() async {
          await result.then((value) {
            print("DetailTopic" + value!.message!);
            this._topic = value!.data!.topic ?? Topic();
          });
        });
        var resultThreads =
            ThreadApi().search("createdAt", "desc", Id, "", value);
        await resultThreads.whenComplete(() async {
          await resultThreads.then((val) {
            this._threads = val!.data!.threads ?? [];
          });
        });
      });
    });
    notifyListeners();
  }
}
