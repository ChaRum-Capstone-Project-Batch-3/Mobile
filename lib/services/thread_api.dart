import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fgd_flutter/models/base_response.dart';
import 'package:fgd_flutter/models/comment/comment_model.dart';
import 'package:fgd_flutter/models/home/followed_thread_response.dart';
import 'package:fgd_flutter/models/thread_detail/get_thread_detail_response.dart';
import 'package:fgd_flutter/models/thread_detail/thread_response.dart';
import 'package:fgd_flutter/models/thread_detail/thread_response.dart';
import 'package:fgd_flutter/shared/api_utils.dart';
import 'package:fgd_flutter/shared/local_storage.dart';

class ThreadApi extends ApiUtils {
  Future<ThreadResponse?> search(String sort, String order, String topic,
      String title, String token) async {
    try {
      Response response = await ApiUtils().dio.get("/thread/1",
          queryParameters: {
            "limit": 100,
            "sort": sort,
            "order": order,
            "topic-id": topic,
            "title": title
          },
          options: Options(headers: {"Authorization": token}));
      print(response.data.toString());
      ThreadResponse result = ThreadResponse.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.type == DioErrorType.other && e.error is SocketException) {
        print("Token not revoked");
      } else {
        rethrow;
      }
    }
  }

  Future<FollowedThreadResponse> getFollowThread(String token) async {
    var response = await dio.get('/thread/follow',
        options: Options(headers: {"Authorization": token}));
    FollowedThreadResponse result =
        FollowedThreadResponse.fromJson(response.data);
    print("get Follow Thread by Token" + response.data.toString());
    return result;
  }

  Future<BaseResponse> likeThread(String id, String token) async {
    var response = await dio.post('/thread/like/id/$id',
        options: Options(headers: {"Authorization": token}));
    BaseResponse result = BaseResponse.fromJson(response.data);
    print("like" + response.data.toString());
    return result;
  }

  Future<BaseResponse> unlikeThread(String id, String token) async {
    var response = await dio.delete('/thread/like/id/$id',
        options: Options(headers: {"Authorization": token}));
    BaseResponse result = BaseResponse.fromJson(response.data);
    print("unlike" + response.data.toString());
    return result;
  }

  Future<BaseResponse> followThread(String id, String token) async {
    var response = await dio.post('/thread/follow/$id',
        options: Options(headers: {"Authorization": token}));
    BaseResponse result = BaseResponse.fromJson(response.data);
    return result;
  }

  Future<BaseResponse> unfollowThread(String id, String token) async {
    var response = await dio.delete('/thread/follow/$id',
        options: Options(headers: {"Authorization": token}));
    BaseResponse result = BaseResponse.fromJson(response.data);
    return result;
  }

  Future<BaseResponse> bookmarkThread(String id, String token) async {
    var response = await dio.post("/thread/bookmark/$id",
        options: Options(headers: {"Authorization": token}));
    BaseResponse result = BaseResponse.fromJson(response.data);
    return result;
  }

  Future<BaseResponse> unbookmarkThread(String id, String token) async {
    var response = await dio.delete("/thread/bookmark/$id",
        options: Options(headers: {"Authorization": token}));
    print(response.data.toString());
    BaseResponse result = BaseResponse.fromJson(response.data);
    return result;
  }

  Future<ThreadResponse> detailThread(String id, String token) async {
    var response = await dio.get('/thread/id/$id',
        options: Options(headers: {"Authorization": token}));
    ThreadResponse result = ThreadResponse.fromJson(response.data);
    return result;
  }

  Future<GetThreadDetailResponse> getThreadDetail(
      String id, String token) async {
    var response = await dio.get('/thread/id/$id',
        options: Options(headers: {"Authorization": token}));
    GetThreadDetailResponse result =
        GetThreadDetailResponse.fromJson(response.data);
    return result;
  }

  Future<BaseResponse> addComment(
      String threadId, CommentModel comment, String token) async {
    var response = await dio.post('/thread/comment/$threadId',
        data: comment.toJson(),
        options: Options(headers: {"Authorization": token}));
    BaseResponse result = BaseResponse.fromJson(response.data);
    return result;
  }
}
