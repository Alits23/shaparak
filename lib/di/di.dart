import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shaparak/bloc/card/card_bloc.dart';
import 'package:shaparak/data/datasource/authentication_datasource.dart';
import 'package:shaparak/data/datasource/banner_datasource.dart';
import 'package:shaparak/data/datasource/basket_datasource.dart';
import 'package:shaparak/data/datasource/category_datasource.dart';
import 'package:shaparak/data/datasource/product_datasource.dart';
import 'package:shaparak/data/datasource/product_detail_datasource.dart';
import 'package:shaparak/data/repository/authentication_repository.dart';
import 'package:shaparak/data/repository/banner_repository.dart';
import 'package:shaparak/data/repository/basket_repository.dart';
import 'package:shaparak/data/repository/category_repository.dart';
import 'package:shaparak/data/repository/producr_detail_repository.dart';
import 'package:shaparak/data/repository/product_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;

Future<void> getInit() async {
  locator.registerSingleton<Dio>(
    Dio(
      BaseOptions(baseUrl: 'https://startflutter.ir/api/'),
    ),
  );
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  // DataSource
  locator
      .registerFactory<IcategoryDatasource>(() => CategoryDatasourceRemote());
  locator.registerFactory<IBannerDatasource>(() => BannerDatasourceRemote());
  locator.registerFactory<IProductDatasource>(() => ProductDatasourceRemote());
  locator.registerFactory<IProductDetailDatasource>(
      () => ProductDetailDatasourceRemote());
  locator.registerFactory<IBasketDatasource>(() => BasketLocalDataSource());
  locator.registerFactory<IAuthDatasource>(() => AuthDatasourceRemote());

  //Repository
  locator.registerFactory<ICategoryRepository>(() => CategoryRepository());
  locator.registerFactory<IBannerRepository>(() => BannerRepository());
  locator.registerFactory<IproductRepository>(() => ProductRepository());
  locator.registerFactory<IProductDetailRepository>(
      () => ProductDetailRepository());
  locator.registerFactory<IBasketRepository>(() => BasketRepository());
  locator.registerFactory<IAuthRepository>(() => AuthRepository());

  //bloc
  locator.registerSingleton<CardBloc>(CardBloc());
}
