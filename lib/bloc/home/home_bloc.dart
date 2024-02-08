import 'package:bloc/bloc.dart';
import 'package:shaparak/bloc/home/home_event.dart';
import 'package:shaparak/bloc/home/home_state.dart';
import 'package:shaparak/data/repository/banner_repository.dart';
import 'package:shaparak/data/repository/category_repository.dart';
import 'package:shaparak/di/di.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _bannerRepository = locator.get();
  final ICategoryRepository _categoryRepository = locator.get();
  HomeBloc() : super(HomeInitState()) {
    on<HomeRequestList>(
      (event, emit) async {
        emit(HomeLoadingState());

        var bannerlist = await _bannerRepository.getBanners();
        var categoryList = await _categoryRepository.getCategories();

        emit(
          HomeResponseState(
            bannerlist: bannerlist,
            categoryList: categoryList,
          ),
        );
      },
    );
  }
}
