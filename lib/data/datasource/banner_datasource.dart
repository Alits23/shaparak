import 'package:dio/dio.dart';
import 'package:shaparak/data/model/banner.dart';
import 'package:shaparak/di/di.dart';

import '../../util/api_exception.dart';

abstract class IBannerDatasource {
  Future<List<BannerCampaign>> getBanners();
}

class BannerDatasourceRemote extends IBannerDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<BannerCampaign>> getBanners() async {
    try {
      var response = await _dio.get('collections/banner/records');
      return response.data['items']
          .map<BannerCampaign>(
              (jsonObject) => BannerCampaign.fromjson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(
        ex.response?.statusCode,
        ex.response?.data['message'],
      );
    } catch (ex) {
      throw ApiException(0, 'unknow error');
    }
  }
}
