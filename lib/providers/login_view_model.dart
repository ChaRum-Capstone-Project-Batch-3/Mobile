import 'package:fgd_flutter/models/login/login.dart';
import 'package:fgd_flutter/services/login_api.dart';
import 'package:fgd_flutter/shared/local_storage.dart';
import 'package:fgd_flutter/state/login_state.dart';
import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  var mPreferences = LocalStorage();
  LoginState _state = LoginState.loaded;
  LoginState get state => _state;
  String _error = "";
  String get error => _error;
  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;

  changeState(LoginState s) {
    this._state = s;
    notifyListeners();
  }

  Future login(Login login) async {
    changeState(LoginState.loading);
    try {
      var result = LoginApi().login(login);
      Future.delayed(Duration(seconds: 2));
      await result.whenComplete(() async {
        await result.then((value) {
          if (value.status != 200) {
            this._error = value.message ?? "";
            notifyListeners();
          } else {
            print("Login Message: " + value.message!);
            mPreferences.setString("token", value.data!.token.toString());
            mPreferences.setBool("isLogin", true);
            changeState(LoginState.loaded);
            this._isSuccess = true;
            notifyListeners();
          }
        });
      });
      notifyListeners();
    } catch (e) {
      changeState(LoginState.error);
      notifyListeners();
    }
  }
}
