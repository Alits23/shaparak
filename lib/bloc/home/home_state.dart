import 'package:dartz/dartz.dart';
import 'package:shaparak/data/model/banner.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeResponseState extends HomeState {
  Either<String, List<BannerCampaign>> response;
  HomeResponseState(this.response);
}
