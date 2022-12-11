import 'package:fgd_flutter/models/thread_detail/thread_response.dart';
import 'package:fgd_flutter/services/thread_api.dart';
import 'package:fgd_flutter/shared/local_storage.dart';
import 'package:fgd_flutter/state/search_thread_state.dart';
import 'package:flutter/material.dart';

class SearchThreadViewModel with ChangeNotifier {
  SearchThreadState _state = SearchThreadState.iddle;
  SearchThreadState get state => _state;
  var mPreferences = LocalStorage();
  List<String> _recentSearch = [];
  List<String> get recentSearch => _recentSearch;
  List<Threads> _thread = [];
  List<Threads> get thread => _thread;
  List<Threads> _popular = [];
  List<Threads> get popular => _popular;
  TextEditingController _teSearch = TextEditingController();
  TextEditingController get teSearch => _teSearch;

  changeState(SearchThreadState s) {
    _state = s;
    notifyListeners();
  }

  getRecent() async {
    var data = mPreferences.getListString('recentSearch');
    await data.whenComplete(() async {
      await data.then((value) {
        _recentSearch = value;
        notifyListeners();
      });
    });
  }

  addRecent(String recent) async {
    if (!this._recentSearch.contains(recent)) {
      this._recentSearch.add(recent);
      mPreferences.setListString('recentSearch', this._recentSearch);
    }
    notifyListeners();
  }

  removeRecent(int index) {
    this._recentSearch.removeAt(index);
    mPreferences.setListString('recentSearch', this._recentSearch);
    notifyListeners();
  }

  clearRecent() {
    this._recentSearch = [];
    mPreferences.setListString('recentSearch', this._recentSearch);
    notifyListeners();
  }

  searchThread(String search) async {
    changeState(SearchThreadState.loading);
    try {
      var token = mPreferences.getString('token');
      await token.whenComplete(() async {
        await token.then((value) async {
          var resultThread =
              ThreadApi().search('updatedAt', 'desc', "", search, value);
          var resultPopular =
              ThreadApi().search("likes", "desc", "", search, value);
          await resultThread.whenComplete(() async {
            await resultThread.then((value) async {
              print(value!.message.toString());
              await resultPopular.whenComplete(() async {
                await resultPopular.then((popularRes) {
                  if (value!.status != 200 && popularRes!.status != 200) {
                    changeState(SearchThreadState.error);
                    notifyListeners();
                  } else {
                    this._thread =
                        value.data!.threads == null ? [] : value.data!.threads!;
                    this._popular = popularRes!.data!.threads == null
                        ? []
                        : popularRes.data!.threads!;
                    changeState(SearchThreadState.loaded);
                    notifyListeners();
                  }
                });
              });
            });
          });
        });
      });
    } catch (e) {
      print(e.toString());
      changeState(SearchThreadState.error);
      notifyListeners();
    }
  }

  setSearch(int index) {
    String data = this._recentSearch.elementAt(index);
    this._teSearch.text = data;
    notifyListeners();
  }
}
