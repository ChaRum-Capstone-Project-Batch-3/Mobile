import 'package:fgd_flutter/models/home/home_thread_response.dart';
import 'package:fgd_flutter/services/home_thread_api.dart';
import 'package:fgd_flutter/shared/local_storage.dart';
import 'package:flutter/material.dart';

class HomeThreadViewModel with ChangeNotifier {
  var mPreferences = LocalStorage();
  List<String> _recentSearch = [];
  List<String> get recentSearch => _recentSearch;
  List<Threads> _thread = [];
  List<Threads> get thread => _thread;
  List<Threads> _popular = [];
  List<Threads> get popular => _popular;
  TextEditingController _teSearch = TextEditingController();
  TextEditingController get teSearch => _teSearch;

  showThread () async {
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

  

  setSearch(int index) {
    String data = this._recentSearch.elementAt(index);
    this._teSearch.text = data;
    notifyListeners();
  }
}
