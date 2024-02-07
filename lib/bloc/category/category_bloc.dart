import 'package:bloc/bloc.dart';
import 'package:shaparak/bloc/category/category_event.dart';
import 'package:shaparak/bloc/category/category_state.dart';
import 'package:shaparak/data/repository/category_repository.dart';
import 'package:shaparak/di/di.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICategoryRepository _repository = locator.get();

  CategoryBloc() : super(CategoryInitiatState()) {
    on<CategoryRequestList>((event, emit) async {
      emit(CategoryLoadingState());

      var response = await _repository.getCategories();
      emit(CategoryResponseState(response));
    });
  }
}
