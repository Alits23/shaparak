import 'package:dartz/dartz.dart';
import 'package:shaparak/data/model/category.dart';

abstract class CategoryState {}

class CategoryInitiatState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryResponseState extends CategoryState {
  Either<String, List<Category>> response;
  CategoryResponseState(this.response);
}
