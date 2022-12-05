import 'package:dio/dio.dart';
import 'package:fgd_flutter/shared/local_storage.dart';

class ApiUtils extends LocalStorage {
  static var uri = "https://charum-api.nyakit.in/api/v1";
  static BaseOptions options = BaseOptions(
    baseUrl: uri,
    connectTimeout: 30000,
    receiveTimeout: 30000,
    headers: {"Content-Type": "application/json", "Accept": "application/json"},
    validateStatus: (status) {
      return status! < 500;
    },
  );
  Dio dio = Dio(options);
}
