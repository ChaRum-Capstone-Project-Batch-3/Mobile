import 'package:fgd_flutter/models/login.dart';
import 'package:fgd_flutter/models/register.dart';
import 'package:fgd_flutter/services/login_api.dart';
import 'package:fgd_flutter/services/register_api.dart';
import 'package:fgd_flutter/shared/local_storage.dart';
import 'package:flutter/material.dart';

class RegisterViewModel with ChangeNotifier {
  var mPreferences = LocalStorage();

  Future<bool> register(Register register) async {
    var result = RegisterApi().register(register);
    await result.whenComplete(() async {
      await result.then((value) async {
        if (value.status != 201) {
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
