import 'package:dartz/dartz.dart';
import 'package:shaparak/data/model/banner.dart';
import 'package:shaparak/data/model/category.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeResponseState extends HomeState {
  Either<String, List<BannerCampaign>> bannerlist;
  Either<String, List<Category>> categoryList;
  HomeResponseState({
    required this.bannerlist,
    required this.categoryList,
  });
}
