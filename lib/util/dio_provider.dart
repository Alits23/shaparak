import 'package:dio/dio.dart';

class DioProvider {
  Dio creatDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://startflutter.ir/api/',
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb2xsZWN0aW9uSWQiOiJfcGJfdXNlcnNfYXV0aF8iLCJleHAiOjE3MTI1Nzc5MTEsImlkIjoiYzdtM3VpN3FmcWcwdmN2IiwidHlwZSI6ImF1dGhSZWNvcmQifQ.9NmGqIQ7eY7hklCRuQLin8apomZ3XV1VTm-AMFxIwX4'
        },
      ),
    );
    return dio;
  }
}
