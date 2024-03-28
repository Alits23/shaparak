import 'package:dio/dio.dart';
import 'package:shaparak/util/api_exception.dart';
import 'package:shaparak/util/auth_manager.dart';
import 'package:shaparak/util/dio_provider.dart';

abstract class IAuthDatasource {
  Future<void> register(
    String username,
    String password,
    String passwordConfirm,
  ); //register

  Future<String> login(
    String identity,
    String password,
  ); //Login
}

class AuthDatasourceRemote extends IAuthDatasource {
  final Dio _dio = DioProvider.creatDioWithoutHeader();

  //register
  @override
  Future<void> register(
    String username,
    String password,
    String passwordConfirm,
  ) async {
    try {
      // ignore: unused_local_variable
      var response = await _dio.post(
        'collections/users/records',
        data: {
          'username': username,
          'password': password,
          'passwordConfirm': passwordConfirm,
        },
      );
      if (response.statusCode == 200) {
        AuthManager.saveUserId(response.data?['id']);
        return response.data['token'];
      }
    } on DioException catch (ex) {
      throw ApiException(
        ex.response?.statusCode,
        ex.response?.data['data']['username']['message'],
      );
    } catch (ex) {
      throw ApiException(0, 'unknow error');
    }
  }

  //login
  @override
  Future<String> login(String identity, String password) async {
    try {
      var response = await _dio.post('collections/users/auth-with-password',
          data: {'identity': identity, 'password': password});
      if (response.statusCode == 200) {
        AuthManager.saveUserId(response.data?['record']['id']);
        return response.data['token'];
      }
    } on DioException catch (ex) {
      throw ApiException(
        ex.response?.statusCode,
        ex.response?.data['message'],
      );
    } catch (ex) {
      throw ApiException(0, 'unknow error');
    }
    return '';
  }
}
