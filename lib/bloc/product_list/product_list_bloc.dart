import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaparak/bloc/product_list/product_list_event.dart';
import 'package:shaparak/bloc/product_list/product_state.dart';

import '../../data/repository/product_repository.dart';
import '../../di/di.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final IproductRepository _productRepository = locator.get();
  ProductListBloc() : super(ProductListInitState()) {
    on<ProductListRequest>((event, emit) async {
      emit(ProductListLoadingState());
      var productList =
          await _productRepository.getProductList(event.categoryId);
      emit(ProductListResponseState(productList));
    });
  }
}
