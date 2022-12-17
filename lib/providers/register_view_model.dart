import 'package:fgd_flutter/models/login/login.dart';
import 'package:fgd_flutter/models/register/register.dart';
import 'package:fgd_flutter/services/login_api.dart';
import 'package:fgd_flutter/services/register_api.dart';
import 'package:fgd_flutter/shared/local_storage.dart';
import 'package:fgd_flutter/state/register_state.dart';
import 'package:flutter/material.dart';

class RegisterViewModel with ChangeNotifier {
  var mPreferences = LocalStorage();
  String _mError = "";
  String get mError => _mError;
  RegisterState _state = RegisterState.loaded;
  RegisterState get state => _state;
  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;

  changeState(RegisterState s) {
    this._state = s;
    notifyListeners();
  }

  Future register(Register register) async {
    changeState(RegisterState.loading);
    Future.delayed(Duration(seconds: 2));
    try {
      var result = RegisterApi().register(register);
      await result.whenComplete(() async {
        await result.then((value) async {
          print(value.status.toString());
          if (value.status != 201) {
            this._mError = value.message ?? "";
            changeState(RegisterState.loaded);
            notifyListeners();
          } else {
            if (value.data!.token!.isNotEmpty) {
              mPreferences.setString("token", value.data!.token.toString());
              mPreferences.setBool("isLogin", true);
              this._isSuccess = true;
              changeState(RegisterState.loaded);
              notifyListeners();
            }
          }
        });
      });
      notifyListeners();
    } catch (e) {
      changeState(RegisterState.error);
      notifyListeners();
    }
  }
}
