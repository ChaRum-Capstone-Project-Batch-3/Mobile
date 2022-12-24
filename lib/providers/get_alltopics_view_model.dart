import 'package:fgd_flutter/services/thread_api.dart';

import 'package:fgd_flutter/shared/local_storage.dart';
import 'package:fgd_flutter/state/space_state.dart';
import 'package:flutter/cupertino.dart';

import '../models/thread/thread.dart';
import '../models/topic/topic.dart';
import '../services/get_alltopic_api.dart';

class AllTopicsViewModel with ChangeNotifier {
  var mPreferences = LocalStorage();
  List<Topic> _topics = [];
  List<Topic> get topics => _topics;
  Topic _topic = Topic();
  Topic get topic => _topic;
  List<Thread> _threads = [];
  List<Thread> get threads => _threads;
  List<Thread> _popular = [];
  List<Thread> get popular => _popular;
  SpaceState _state = SpaceState.loaded;
  SpaceState get state => _state;
  TextEditingController _teSearch = TextEditingController();
  TextEditingController get teSearch => _teSearch;

  changeState(SpaceState f) {
    this._state = f;
  }

  searchTopic(String topic) async {
    var token = mPreferences.getString("token");
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
      var token = mPreferences.getString("token");
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
    changeState(SpaceState.loading);
    try {
      var token = mPreferences.getString("token");
      await token.whenComplete(() async {
        await token.then((value) async {
          var result = GetTopicsApi().detailTopics(Id, value);
          await result.whenComplete(() async {
            await result.then((value) {
              print("DetailTopic" + value!.message!);
              this._topic = value!.data!.topic ?? Topic();
            });
          });
          var resultThreads = ThreadApi()
              .search("createdAt", "desc", Id, this._teSearch.text, value);
          await resultThreads.whenComplete(() async {
            await resultThreads.then((val) {
              this._threads = val!.data!.threads ?? [];
            });
          });
          var threadPopular = ThreadApi()
              .search("likes", "desc", Id, this._teSearch.text, value);
          await threadPopular.whenComplete(() async {
            await threadPopular.then((val) {
              this._popular = val!.data!.threads ?? [];
            });
          });
        });
      });
    } catch (e) {
      print(e);
      notifyListeners();
    }
    notifyListeners();
  }

  likeThread(int index, String type, String id) async {
    var token = mPreferences.getString("token");
    if (type == "thread") {
      this._threads[index].isLiked = !this._threads[index].isLiked!;
      await token.whenComplete(() async {
        await token.then((value) async {
          await ThreadApi().likeThread(this._threads[index].sId!, value);
        });
      });
    } else {
      this._popular[index].isLiked = !this._popular[index].isLiked!;
      await token.whenComplete(() async {
        await token.then((value) async {
          await ThreadApi().likeThread(this._popular[index].sId!, value);
        });
      });
    }
    await topicDetail(id);
    notifyListeners();
  }

  unlikeThread(int index, String type, String id) async {
    var token = mPreferences.getString("token");
    if (type == "thread") {
      this._threads[index].isLiked = !this._threads[index].isLiked!;
      await token.whenComplete(() async {
        await token.then((value) async {
          await ThreadApi().unlikeThread(this._threads[index].sId!, value);
        });
      });
    } else {
      this._popular[index].isLiked = !this._popular[index].isLiked!;
      await token.whenComplete(() async {
        await token.then((value) async {
          await ThreadApi().unlikeThread(this._popular[index].sId!, value);
        });
      });
    }
    await topicDetail(id);
    notifyListeners();
  }

  followThread(String id, String topicId) async {
    var token = mPreferences.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        await ThreadApi().followThread(id, value);
        await topicDetail(topicId);
        notifyListeners();
      });
    });
  }

  unfollowThread(String id, String topicId) async {
    var token = mPreferences.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        await ThreadApi().unfollowThread(id, value);
        await topicDetail(topicId);
        notifyListeners();
      });
    });
  }

  bookmarkThread(String id, String topicId) async {
    var token = mPreferences.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        await ThreadApi().bookmarkThread(id, value);
        await topicDetail(topicId);
        notifyListeners();
      });
    });
  }

  unbookmarkThread(String id, String topicId) async {
    var token = mPreferences.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        await ThreadApi().unbookmarkThread(id, value);
        await topicDetail(topicId);
        notifyListeners();
      });
    });
  }
}
