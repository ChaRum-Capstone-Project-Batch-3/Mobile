import 'package:fgd_flutter/models/bookmark/bookmark_response.dart';
import 'package:fgd_flutter/services/bookmark_api.dart';
import 'package:fgd_flutter/shared/local_storage.dart';
import 'package:fgd_flutter/state/bookmark_state.dart';
import 'package:flutter/material.dart';

class BookmarkViewModel with ChangeNotifier {
  var mPreferences = LocalStorage();
  BookmarkState _state = BookmarkState.loaded;
  BookmarkState get state => _state;
  List<Bookmarks> _bookmarks = [];
  List<Bookmarks> get bookmarks => _bookmarks;

  changeState(BookmarkState s) {
    this._state = s;
    // notifyListeners();
  }

  initial() async {
    changeState(BookmarkState.loading);
    try {
      var token = mPreferences.getString("token");
      await token.whenComplete(() async {
        await token.then((value) async {
          var result = BookmarkApi().getBookmark(value);
          await result.whenComplete(() async {
            await result.then((val) {
              if (val.status == 200) {
                this._bookmarks = val.data!.bookmarks ?? [];
                changeState(BookmarkState.loaded);
              } else {
                changeState(BookmarkState.error);
              }
            });
          });
        });
      });
      notifyListeners();
    } catch (e) {
      print(e.toString());
      changeState(BookmarkState.error);
    }
  }

  getBookmark() async {
    var token = mPreferences.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        var result = BookmarkApi().getBookmark(value);
        await result.whenComplete(() async {
          await result.then((val) {
            if (val.status == 200) {
              this._bookmarks = val.data!.bookmarks ?? [];
            }
          });
        });
      });
    });
    notifyListeners();
  }

  likeThread(int index) async {
    var token = mPreferences.getString("token");
    this._bookmarks[index].thread!.isLiked =
        !this._bookmarks[index].thread!.isLiked!;
    await token.whenComplete(() async {
      await token.then((value) async {
        var result = BookmarkApi()
            .likeThread(this._bookmarks[index].thread!.sId!, value);
        await result.whenComplete(() async {
          await result.then((val) async {
            // if (val.status == 201) {
            await getBookmark();
            notifyListeners();
            // }
          });
        });
      });
    });
  }

  unlikeThread(int index) async {
    var token = mPreferences.getString("token");
    this._bookmarks[index].thread!.isLiked =
        !this._bookmarks[index].thread!.isLiked!;
    await token.whenComplete(() async {
      await token.then((value) async {
        await BookmarkApi()
            .unlikeThread(this._bookmarks[index].thread!.sId!, value);
        await getBookmark();
        notifyListeners();
      });
    });
  }

  followThread(String id) async {
    var token = mPreferences.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        await BookmarkApi().followThread(id, value);
        await getBookmark();
        notifyListeners();
      });
    });
  }

  unfollowThread(String id) async {
    var token = mPreferences.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        await BookmarkApi().unfollowThread(id, value);
        await getBookmark();
        notifyListeners();
      });
    });
  }

  bookmarkThread(String id) async {
    var token = mPreferences.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        await BookmarkApi().bookmarkThread(id, value);
        await getBookmark();
        notifyListeners();
      });
    });
  }

  unbookmarkThread(String id) async {
    var token = mPreferences.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        await BookmarkApi().unbookmarkThread(id, value);
        await getBookmark();
        print("unbookmark");
        notifyListeners();
      });
    });
  }
}
