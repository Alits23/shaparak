import 'package:bloc/bloc.dart';
import 'package:shaparak/bloc/product_detail/product_detail_event.dart';
import 'package:shaparak/bloc/product_detail/product_detail_state.dart';
import 'package:shaparak/data/repository/basket_repository.dart';
import 'package:shaparak/data/repository/producr_detail_repository.dart';
import 'package:shaparak/di/di.dart';

import '../../data/model/basket_item.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductDetailRepository _detailRepository = locator.get();
  final IBasketRepository _basketRepository = locator.get();
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
        var productProperties =
            await _detailRepository.getProductProperties(event.productId);
        emit(
          ProductResponseState(
            productImages,
            productVariant,
            categoryId,
            productProperties,
          ),
        );
      },
    );
    on<ProductAddToBasket>((event, emit) {
      var basketItem = BasketItem(
        event.product.collectionId,
        event.product.discount_price,
        event.product.id,
        event.product.name,
        event.product.price,
        event.product.thumbnail,
        event.product.category,
      );
      _basketRepository.addProductToBasket(basketItem);
    });
  }
}
