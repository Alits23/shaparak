import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shaparak/util/auth_manager.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

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
    )..interceptors.addAll(
      [
        InterceptorsWrapper(
          onError: (DioException err, handler) async {
            debugPrint(err.response?.statusCode.toString());
            debugPrint(err.response?.statusMessage.toString());
            if (err.response!.statusCode == 401) {
              AuthManager.logout();
            }
            return handler.next(err);
          },
        ),
        TalkerDioLogger(
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printResponseHeaders: false,
            printResponseMessage: true,
            printResponseData: true,
            printErrorData: true,
          ),
        ),
      ],
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
