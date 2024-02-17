import 'package:bloc/bloc.dart';
import 'package:shaparak/bloc/product_detail/product_detail_event.dart';
import 'package:shaparak/bloc/product_detail/product_detail_state.dart';
import 'package:shaparak/data/repository/producr_detail_repository.dart';
import 'package:shaparak/di/di.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductDetailRepository _detailRepository = locator.get();
  ProductBloc() : super(ProductInitState()) {
    on<ProductRequestList>(
      (event, emit) async {
        emit(ProductLoadingState());
        var productImages =
            await _detailRepository.getProductImage(event.productId);
        var productVariant =
            await _detailRepository.getproductVariants(event.productId);
        var categoryId =
            await _detailRepository.getProductCategory(event.categoryId);
        emit(
          ProductResponseState(
            productImages,
            productVariant,
            categoryId,
          ),
        );
      },
    );
  }
}
