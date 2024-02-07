import 'package:dartz/dartz.dart';
import 'package:shaparak/data/datasource/banner_datasource.dart';
import 'package:shaparak/data/model/banner.dart';
import 'package:shaparak/di/di.dart';

import '../../util/api_exception.dart';

abstract class IBannerRepository {
  Future<Either<String, List<BannerCampaign>>> getBanners();
}

class BannerRepository extends IBannerRepository {
  final IBannerDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<BannerCampaign>>> getBanners() async {
    try {
      var response = await _datasource.getBanners();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای ناشناخته');
    }
  }
}
