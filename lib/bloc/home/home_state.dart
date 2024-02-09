import 'package:dartz/dartz.dart';
import 'package:shaparak/data/model/banner.dart';
import 'package:shaparak/data/model/category.dart';
import 'package:shaparak/data/model/product.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeResponseState extends HomeState {
  Either<String, List<BannerCampaign>> bannerlist;
  Either<String, List<Category>> categoryList;
  Either<String, List<Product>> productList;
  Either<String, List<Product>> productListHotest;
  Either<String, List<Product>> productListBestSeller;
  HomeResponseState({
    required this.bannerlist,
    required this.categoryList,
    required this.productList,
    required this.productListHotest,
    required this.productListBestSeller,
  });
}
