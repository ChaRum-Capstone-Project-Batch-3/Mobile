import 'package:fgd_flutter/models/create_thread/create_thread.dart';
import 'package:fgd_flutter/models/create_thread/create_thread_response.dart';
import 'package:fgd_flutter/services/create_thread_api.dart';
import 'package:fgd_flutter/shared/local_storage.dart';
import 'package:flutter/material.dart';

//make provider state management to create thread
class CreateThreadViewModel extends ChangeNotifier {
  var mPreference = LocalStorage();
  
  Future<bool> CreateThread(CreateThreadBody threadBody) async {
    var token = mPreference.getString('token');
    await token.whenComplete(() async {
      await token.then((value) async {
        var result = CreadThreadApi().createThread(value, threadBody);
        await result.whenComplete(() async {
          await result.then((value) {
            if (value.status != 201) {
              notifyListeners();
              return false;
            }
          });
        });
      });
    });

    notifyListeners();
    return true;
  }
}
