import 'package:fgd_flutter/models/space/get_all_topics.dart';
import 'package:fgd_flutter/models/space/get_detail_topics.dart';

import 'package:fgd_flutter/models/thread_detail/thread_response.dart';
import 'package:fgd_flutter/services/get_alltopics_api.dart';
import 'package:fgd_flutter/services/thread_api.dart';

import 'package:fgd_flutter/shared/local_storage.dart';
import 'package:fgd_flutter/state/space_state.dart';
import 'package:flutter/cupertino.dart';

class AllTopicsViewModel with ChangeNotifier {
  var mPrefenreces = LocalStorage();
  List<Topics> _topics = [];
  List<Topics> get topics => _topics;
  DetailTopic _topic = DetailTopic();
  DetailTopic get topic => _topic;
  List<Threads> _threads = [];
  List<Threads> get threads => _threads;
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
            this._topic = value!.data!.topic ?? DetailTopic();
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
  }
}
