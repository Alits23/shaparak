import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaparak/bloc/product_list/product_list_bloc.dart';
import 'package:shaparak/bloc/product_list/product_list_event.dart';
import 'package:shaparak/bloc/product_list/product_state.dart';
import 'package:shaparak/data/model/category.dart';
import 'package:shaparak/data/model/product.dart';
import 'package:shaparak/view/home_screen.dart';
import 'package:shaparak/widgets/product_container.dart';

import '../constans/color.dart';

class ProductListScreen extends StatefulWidget {
  final Category category;
  const ProductListScreen(this.category, {super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  ValueNotifier<List<Product>> searchList = ValueNotifier([]);
  List<Product> allProductList = [];
  TextEditingController searchListController = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<ProductListBloc>(context)
        .add(ProductListRequest(widget.category.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductListBloc, ProductListState>(
      listener: (context, state) {
        if (state is ProductListResponseState) {
          state.productList.fold((l) => null, (r) {
            searchList.value = r;
            allProductList = r;
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: isLight.value
              ? CustomColors.backgroundScreenColor
              : CustomColors.backgroundScreenColorDark,
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                AppBarProductList(widget.category.title),
                SearchTextfield(
                    searchListController: searchListController,
                    searchList: searchList,
                    allProductList: allProductList),
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
                    return ValueListenableBuilder(
                      valueListenable: searchList,
                      builder: (context, searchList, child) {
                        return ProductGrid(searchList);
                      },
                    );
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

class SearchTextfield extends StatelessWidget {
  const SearchTextfield({
    super.key,
    required this.searchListController,
    required this.searchList,
    required this.allProductList,
  });

  final TextEditingController searchListController;
  final ValueNotifier<List<Product>> searchList;
  final List<Product> allProductList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 32,
          right: 32,
          bottom: 20,
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextField(
            controller: searchListController,
            onChanged: (value) {
              if (value.isEmpty) {
                searchList.value = allProductList;
              }
              List<Product> tempList = allProductList
                  .where((element) =>
                      element.name.toLowerCase().contains(value.toLowerCase()))
                  .toList();
              searchList.value = tempList;
            },
            cursorColor: CustomColors.blueIndicator,
            style: const TextStyle(
              color: CustomColors.backgroundScreenColorDark,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                    color: CustomColors.backgroundScreenColorDark),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: CustomColors.blueIndicator),
              ),
              hintText: 'جستجوی محصول',
              hintStyle: const TextStyle(
                color: CustomColors.gery,
                fontSize: 16,
              ),
              suffixIcon: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: Icon(Icons.search_outlined)),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  final List<Product> productList;
  const ProductGrid(
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
  final String category;
  const AppBarProductList(
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
