import 'package:fgd_flutter/models/login.dart';
import 'package:fgd_flutter/services/login_api.dart';
import 'package:fgd_flutter/shared/local_storage.dart';
import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  var mPreferences = LocalStorage();

  Future<bool> login(Login login) async {
    var result = LoginApi().login(login);
    await result.whenComplete(() async {
      await result.then((value) {
        if (value.status != 200) {
          return false;
        }
        mPreferences.setString("token", value.data!.token.toString());
        mPreferences.setBool("isLogin", true);
      });
    });
    notifyListeners();
    return true;
  }
}
