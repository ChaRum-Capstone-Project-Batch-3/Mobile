import 'package:fgd_flutter/models/create_thread/create_thread.dart';
import 'package:fgd_flutter/models/create_thread/create_thread_response.dart';
import 'package:fgd_flutter/models/home/followed_thread_response.dart';
import 'package:fgd_flutter/models/topic/topic_response.dart';
import 'package:fgd_flutter/services/create_thread_api.dart';
import 'package:fgd_flutter/shared/local_storage.dart';
import 'package:fgd_flutter/state/create_state.dart';
import 'package:flutter/material.dart';

//make provider state management to create thread
class CreateThreadViewModel extends ChangeNotifier {
  CreateState _state = CreateState.loaded;
  CreateState get state => _state;
  var mPreference = LocalStorage();
  String _topicID = "";
  String get topicID => _topicID;
  List<Topics> _topics = [];
  List<Topics> get topics => _topics;
  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;

  changeState(CreateState s) {
    this._state = s;
  }

  Future<bool> createThread(CreateThreadBody threadBody) async {
    changeState(CreateState.loading);
    try {
      var token = mPreference.getString('token');
      await token.whenComplete(() async {
        await token.then((value) async {
          var result = CreadThreadApi().createThread(value, threadBody);
          Future.delayed(Duration(seconds: 2));
          await result.whenComplete(() async {
            await result.then((value) {
              if (value.status != 201) {
                changeState(CreateState.loaded);
                notifyListeners();
                return false;
              } else {
                changeState(CreateState.loaded);
                this._isSuccess = true;
                notifyListeners();
              }
            });
          });
        });
      });
    } catch (e) {
      print(e);
      notifyListeners();
    }
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
