import 'package:dio/dio.dart';

class ApiException implements Exception {
  int? code;
  String? message;
  Response<dynamic>? response;
  ApiException(this.code, this.message, {this.response}) {
    if (code != 400) {
      return;
    }
    if (message == 'Failed to authenticate.') {
      message = 'نام کاربری یا رمز عبور اشتباه است';
    }
    if (message == 'Failed to create record.') {
      if (response?.data['data']['username'] != null) {
        if (response?.data['data']['username']['message'] ==
            'The username is invalid or already in use.') {
          message = 'نام کاربری نامعتبر یا قبلا استفاده شده';
        }
      }
    }
    if (message == 'Something went wrong while processing your request.') {
      if (response?.data['data']['identity'] != null) {
        if (response?.data['data']['identity']['message'] ==
            'Cannot be blank.') {
          message = 'نام کاربری را وارد  کنید';
        }
      }
    }
    if (message == 'Something went wrong while processing your request.') {
      if (response?.data['data']['password'] != null) {
        if (response?.data['data']['password']['message'] ==
            'Cannot be blank.') {
          message = 'رمز عبور را وارد  کنید';
        }
      }
    }
    if (message == 'Failed to create record.') {
      if (response?.data['data']['password'] != null) {
        if (response?.data['data']['password']['message'] ==
            'The length must be between 8 and 72.') {
          message = 'رمزعبور حداقل باید 8 کاراکتر باشد';
        }
      }
    }
    if (message == 'Failed to create record.') {
      if (response?.data['data']['passwordConfirm'] != null) {
        if (response?.data['data']['passwordConfirm']['message'] ==
            'Values don${'\u0027'}t match.') {
          message = 'رمزعبور یا تکرار آن اشتباه است';
        }
      }
    }
  }
}
