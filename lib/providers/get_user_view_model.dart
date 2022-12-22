import 'package:fgd_flutter/models/user/user.dart';
import 'package:fgd_flutter/models/home/home_thread_response.dart';
import 'package:flutter/material.dart';

import '../services/user_api.dart';
import '../shared/local_storage.dart';

class GetUserViewModel with ChangeNotifier {
  var mPreferences = LocalStorage();
  User _user = User();
  User get user => _user;

  getUsers() async {
    try {
      var token = mPreferences.getString('token');
      await token.whenComplete(() async {
        await token.then((value) async {
          var resultGetUser = UserApi().getUser(value);
          await resultGetUser.whenComplete(() async {
            await resultGetUser.then((value) {
              this._user = value.data!.user!;
              notifyListeners();
            });
          });
        });
      });
    } catch (e) {
      print(e.toString());
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
}
