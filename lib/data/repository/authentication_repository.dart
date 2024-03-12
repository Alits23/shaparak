import 'package:dartz/dartz.dart';
import 'package:shaparak/data/datasource/authentication_datasource.dart';
import 'package:shaparak/di/di.dart';
import 'package:shaparak/util/api_exception.dart';
import 'package:shaparak/util/auth_manager.dart';

abstract class IAuthRepository {
  Future<Either<String, String>> register(
    String username,
    String password,
    String passwordConfirm,
  ); //register

  Future<Either<String, String>> login(
    String identity,
    String password,
  ); //login
}

class AuthRepository extends IAuthRepository {
  final IAuthDatasource _datasource = locator.get();
  @override
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm) async {
    try {
      await _datasource.register(username, password, passwordConfirm);
      return right('ثبت نام انجام شد');
    } on ApiException catch (ex) {
      return left(ex.message ?? ' خطای ناشناخته ');
    }
  }

  @override
  Future<Either<String, String>> login(String identity, String password) async {
    try {
      String token = await _datasource.login(identity, password);
      if (token.isNotEmpty) {
        AuthManager.saveToken(token);
        return right('شما وارد شدید');
      } else {
        return left('خطایی در ورود رخ داده است');
      }
    } on ApiException {
      return left('نام کاربری یا رمز عبور اشتباه است');
    }
  }
}
