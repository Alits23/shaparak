import 'package:dio/dio.dart';
import 'package:shaparak/util/auth_manager.dart';

class DioProvider {
  static Dio creatDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://startflutter.ir/api/',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AuthManager.readAuth()}'
        },
      ),
    );
    return dio;
  }

  static Dio creatDioWithoutHeader() {
    Dio dio = Dio(
      BaseOptions(baseUrl: 'https://startflutter.ir/api/'),
    );
    return dio;
  }
}
