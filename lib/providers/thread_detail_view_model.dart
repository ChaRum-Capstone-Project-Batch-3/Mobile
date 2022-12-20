import 'package:fgd_flutter/models/thread/thread.dart';
import 'package:fgd_flutter/services/thread_detail_api.dart';
import 'package:fgd_flutter/shared/local_storage.dart';
import 'package:flutter/material.dart';

import '../models/thread_detail/get_thread_detail_response.dart';

class ThreadDetailViewModel with ChangeNotifier {
  var mPreferences = LocalStorage();
  Thread _thread = Thread();
  Thread get thread => _thread;

  getThread(String id) async {
    try {
      var token = mPreferences.getString('token');
      await token.whenComplete(() async {
        await token.then((value) async {
          var resultGetThread = ThreadDetailApi().getThread(id, value);
          await resultGetThread.whenComplete(() async {
            await resultGetThread.then((value) {
              if (value!.status == 200) {
                this._thread = value.data!.thread!;
              }
            });
          });
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
