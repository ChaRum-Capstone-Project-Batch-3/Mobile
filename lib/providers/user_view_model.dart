import 'package:fgd_flutter/models/account/get_user_response.dart';
import 'package:flutter/material.dart';

import '../services/user_api.dart';
import '../shared/local_storage.dart';

class UserViewModel with ChangeNotifier {
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
            });
          });
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
