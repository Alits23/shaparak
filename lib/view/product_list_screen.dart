import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaparak/bloc/product_list/product_list_bloc.dart';
import 'package:shaparak/bloc/product_list/product_list_event.dart';
import 'package:shaparak/bloc/product_list/product_state.dart';
import 'package:shaparak/data/model/category.dart';
import 'package:shaparak/data/model/product.dart';
import 'package:shaparak/widgets/product_container.dart';

import '../constans/color.dart';

class ProductListScreen extends StatefulWidget {
  Category category;
  ProductListScreen(this.category, {super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductListBloc>(context)
        .add(ProductListRequest(widget.category.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListBloc, ProductListState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                AppBarProductList(widget.category.title),
                if (state is ProductListLoadingState) ...{
                  const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                },
                if (state is ProductListResponseState) ...{
                  state.productList.fold((l) {
                    return SliverToBoxAdapter(
                      child: Center(child: Text(l)),
                    );
                  }, (r) {
                    return ProductGrid(r);
                  })
                }
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProductGrid extends StatelessWidget {
  List<Product> productList;
  ProductGrid(
    this.productList, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0, bottom: 20),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          childCount: productList.length,
          (context, index) => ProductContainer(productList[index]),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          childAspectRatio: 2 / 2.8,
        ),
      ),
    );
  }
}

class AppBarProductList extends StatelessWidget {
  String category;
  AppBarProductList(
    this.category, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
            right: 44.0, left: 44.0, bottom: 32.0, top: 5.0),
        child: Container(
          height: 56.0,
          decoration: BoxDecoration(
            color: CustomColors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 16.0,
              ),
              Image.asset('assets/images/icon_apple_blue.png'),
              Expanded(
                child: Text(
                  category,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'sb',
                    color: CustomColors.blue,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(
                width: 38.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
