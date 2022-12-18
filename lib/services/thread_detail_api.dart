import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fgd_flutter/models/base_response.dart';
import 'package:fgd_flutter/models/bookmark/like_thread_response.dart';
import 'package:fgd_flutter/models/thread_detail/get_thread_detail_response.dart';
import 'package:fgd_flutter/shared/api_utils.dart';
import 'package:fgd_flutter/shared/local_storage.dart';

class ThreadDetailApi extends ApiUtils {
  Future<GetThreadDetailResponse?> getThread(
      String threadId, String token) async {
    GetThreadDetailResponse result = GetThreadDetailResponse();
    try {
      Response response = await ApiUtils().dio.get("/thread/id/$threadId",
          options: Options(headers: {"Authorization": token}));
      print(response.data.toString());

      GetThreadDetailResponse result =
          GetThreadDetailResponse.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.type == DioErrorType.other && e.error is SocketException) {
        print("Token not revoked");
      } else {
        rethrow;
      }
    }
  }

  Future<LikeThreadResponse> likeThread(String id, String token) async {
    var response = await dio.post('/thread/like/id/$id',
        options: Options(headers: {"Authorization": token}));
    LikeThreadResponse result = LikeThreadResponse.fromJson(response.data);
    print("like" + response.data.toString());
    return result;
  }

  Future<LikeThreadResponse> unlikeThread(String id, String token) async {
    var response = await dio.delete('/thread/like/id/$id',
        options: Options(headers: {"Authorization": token}));
    LikeThreadResponse result = LikeThreadResponse.fromJson(response.data);
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
}
