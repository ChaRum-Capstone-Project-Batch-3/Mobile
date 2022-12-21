import 'dart:io';

import 'package:dio/dio.dart';

import 'package:fgd_flutter/shared/api_utils.dart';
import 'package:fgd_flutter/shared/router.dart';

import '../models/space/get_all_topics.dart';
import '../models/space/get_detail_topics.dart';

// class AllTopics extends ApiUtils {
//   Future<getTopics> topics(String sort, String order, String topic,
//       String title, String token) async {
//         try {}
//     var response =
//         await ApiUtils().dio.get("/Topic/{Page}", queryParameters: );
//     print(response.data.toString());
//     var data = getTopics.fromJson(response.data);
//     return data;
//   }
// }

class GetTopicsApi extends ApiUtils {
  Future<GetTopics?> topics(String sort, String order, String topic,
      String title, String token) async {
    try {
      var response = await dio.get('/topic/1',
          queryParameters: {
            "limit": 1000,
            "sort": "createdAt",
            "order": "desc",
            "topic": topic,
          },
          options: Options(headers: {"Authorization": token}));
      print(response.data.toString());
      GetTopics result = GetTopics.fromJson(response.data);
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future<getDetailTopics?> detailTopics(String Id, String token) async {
    print("topicId"+Id);
    try {
      var response = await dio.get("/topic/id/$Id",
          options: Options(headers: {"Authorization": token}));
      getDetailTopics result = getDetailTopics.fromJson(response.data);
      print(response.data.toString());
      return result;
    } catch (e) {
      print(e);
    }
  }
}