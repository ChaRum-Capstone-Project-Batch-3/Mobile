import 'package:fgd_flutter/models/create_thread/create_thread.dart';
import 'package:fgd_flutter/models/create_thread/create_thread_response.dart';
import 'package:fgd_flutter/models/topic/topic_response.dart';
import 'package:fgd_flutter/services/create_thread_api.dart';
import 'package:fgd_flutter/shared/local_storage.dart';
import 'package:flutter/material.dart';

//make provider state management to create thread
class CreateThreadViewModel extends ChangeNotifier {
  var mPreference = LocalStorage();
  String _topicID = "";
  String get topicID => _topicID;
  List<Topics> _topics = [];
  List<Topics> get topics => _topics;

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

  getTopic() async {
    var token = mPreference.getString("token");
    await token.whenComplete(() async {
      await token.then((value) async {
        var result = CreadThreadApi().getTopic(value);
        await result.whenComplete(() async {
          await result.then((val) {
            if (val.status == 200) {
              this._topics = val.data!.topics ?? [];
            }
          });
        });
      });
    });
    notifyListeners();
  }

  setTopic(int index) {
    this._topics.forEach((element) => element.isSelected = false);
    this._topics[index].isSelected = true;
    this._topicID = this._topics[index].sId!;
    print(this._topicID);
    notifyListeners();
  }
}
