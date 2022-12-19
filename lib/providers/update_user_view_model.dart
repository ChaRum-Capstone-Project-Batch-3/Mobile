import 'package:fgd_flutter/models/account/update_user_response.dart';
import 'package:flutter/material.dart';

import '../models/account/update_user_model.dart';
import '../services/user_api.dart';
import '../shared/local_storage.dart';
import '../state/user_state.dart';

class UpdateUserViewModel with ChangeNotifier {
  var mPreferences = LocalStorage();
  UserState _state = UserState.loaded;
  User _user = User();
  User get user => _user;

  changeState(UserState s) {
    this._state = s;
    notifyListeners();
  }

  Future<bool> updateUsers(UpdateUserModel users) async {
    try {
      var token = mPreferences.getString('token');
      await token.whenComplete(() async {
        await token.then((value) async {
          var result = UserApi().updateUser(value, users);
          await result.whenComplete(() async {
            await result.then((value) {
              if (value.status != 200) {
                print(value.message);
                notifyListeners();
                return false;
              }
              this._user = value.data!.user!;
              print(value.data);
              notifyListeners();
              
            });
          });
        });
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
