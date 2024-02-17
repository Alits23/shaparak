import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaparak/bloc/product_detail/product_detail_bloc.dart';
import 'package:shaparak/bloc/product_detail/product_detail_event.dart';
import 'package:shaparak/bloc/product_detail/product_detail_state.dart';
import 'package:shaparak/constans/color.dart';
import 'package:shaparak/data/model/category.dart';
import 'package:shaparak/data/model/product.dart';
import 'package:shaparak/data/model/product_image.dart';
import 'package:shaparak/data/model/product_variant.dart';
import 'package:shaparak/data/model/variant.dart';
import 'package:shaparak/data/model/variant_type.dart';
import 'package:shaparak/widgets/cashed_image.dart';

class ProductDetailScreen extends StatefulWidget {
  Product product;
  ProductDetailScreen(this.product, {super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context).add(
      ProductRequestList(widget.product.id, widget.product.category),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                if (state is ProductLoadingState) ...{
                  const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                },
                if (state is ProductResponseState) ...{
                  state.categoryId.fold((l) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'دسته بندی',
                          style: TextStyle(
                              fontFamily: 'sb',
                              fontSize: 16,
                              color: CustomColors.blue),
                        ),
                      ),
                    );
                  }, (productCategory) {
                    return AppBarProduct(productCategory.title!);
                  })
                },
                SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontFamily: 'sb',
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                if (state is ProductResponseState) ...{
                  state.productImages.fold((l) {
                    return SliverToBoxAdapter(
                      child: Text(l),
                    );
                  }, (imageList) {
                    return GalleryContainer(
                      widget.product.thumbnail,
                      imageList,
                    );
                  })
                },
                if (state is ProductResponseState) ...{
                  state.productVariant.fold((l) {
                    return SliverToBoxAdapter(
                      child: Text(l),
                    );
                  }, (productvariantList) {
                    return VariantContainerGenerator(productvariantList);
                  })
                },
                const SpecifiactionProduct(),
                const InfoProduct(),
                const UsersComment(),
                const SliverToBoxAdapter(
                    child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PriceTagButton(),
                      SizedBox(
                        width: 5.0,
                      ),
                      AddToBasketButton(),
                    ],
                  ),
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}

class PriceTagButton extends StatelessWidget {
  const PriceTagButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 150,
          height: 60,
          decoration: BoxDecoration(
            color: CustomColors.green,
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              width: 170,
              height: 53,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Center(
                child: Row(
                  children: [
                    const Text(
                      'تومان',
                      style: TextStyle(
                        color: CustomColors.red,
                        fontFamily: 'sm',
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '49,000,000',
                          style: TextStyle(
                            color: CustomColors.white,
                            fontFamily: 'sm',
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          '48,888,888',
                          style: TextStyle(
                            color: CustomColors.white,
                            fontFamily: 'sm',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 20,
                      width: 42,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        color: Colors.red,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 6.0),
                        child: Text(
                          '99%',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: CustomColors.white,
                            fontSize: 15.0,
                            fontFamily: 'sm',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AddToBasketButton extends StatelessWidget {
  const AddToBasketButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 150,
          height: 60,
          decoration: BoxDecoration(
            color: CustomColors.blue,
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              width: 170,
              height: 53,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: const Center(
                child: Text(
                  'افزودن به سبد خرید',
                  style: TextStyle(
                    color: CustomColors.white,
                    fontFamily: 'sb',
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class UsersComment extends StatelessWidget {
  const UsersComment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 44.0, right: 44.0),
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              width: 1,
              color: CustomColors.gery,
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Image.asset('assets/images/icon_left_categroy.png'),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'مشاهده',
                style: TextStyle(
                    fontFamily: 'sm', fontSize: 12, color: CustomColors.blue),
              ),
              const Spacer(),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    width: 26.0,
                    height: 26.0,
                    decoration: BoxDecoration(
                      color: CustomColors.red,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  Positioned(
                    right: 15.0,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      width: 26.0,
                      height: 26.0,
                      decoration: BoxDecoration(
                        color: CustomColors.green,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 30.0,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      width: 26.0,
                      height: 26.0,
                      decoration: BoxDecoration(
                        color: CustomColors.blue,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 45.0,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      width: 26.0,
                      height: 26.0,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 60.0,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      width: 26.0,
                      height: 26.0,
                      decoration: BoxDecoration(
                        color: CustomColors.gery,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Center(
                        child: Text(
                          '+10',
                          style: TextStyle(
                            color: CustomColors.white,
                            fontFamily: 'sb',
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                ': نظرات کاربران',
                style: TextStyle(
                  fontFamily: 'sb',
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoProduct extends StatelessWidget {
  const InfoProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 44.0, right: 44.0),
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              width: 1,
              color: CustomColors.gery,
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Image.asset('assets/images/icon_left_categroy.png'),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'مشاهده',
                style: TextStyle(
                    fontFamily: 'sm', fontSize: 12, color: CustomColors.blue),
              ),
              const Spacer(),
              const Text(
                ': توضیحات محصول',
                style: TextStyle(
                  fontFamily: 'sb',
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SpecifiactionProduct extends StatelessWidget {
  const SpecifiactionProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 44.0, right: 44.0),
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              width: 1,
              color: CustomColors.gery,
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Image.asset('assets/images/icon_left_categroy.png'),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'مشاهده',
                style: TextStyle(
                    fontFamily: 'sm', fontSize: 12, color: CustomColors.blue),
              ),
              const Spacer(),
              const Text(
                ': مشخصات فنی',
                style: TextStyle(
                  fontFamily: 'sb',
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VariantContainerGenerator extends StatelessWidget {
  List<ProductVariant> productVariantList;
  VariantContainerGenerator(
    this.productVariantList, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              for (var productVariant in productVariantList) ...{
                if (productVariant.variantList.isNotEmpty) ...{
                  VariantgeneratorChild(productVariant)
                }
              }
            ],
          )),
    );
  }
}

class VariantgeneratorChild extends StatelessWidget {
  ProductVariant productVariant;
  VariantgeneratorChild(this.productVariant, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 44.0, left: 44.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productVariant.variantType.title,
            style: const TextStyle(fontSize: 12.0, fontFamily: 'sm'),
          ),
          const SizedBox(
            height: 10.0,
          ),
          if (productVariant.variantType.type == VariantTypeEnum.COLOR) ...{
            colorVariantList(productVariant.variantList)
          },
          if (productVariant.variantType.type == VariantTypeEnum.STORAGE) ...{
            StorageVariantList(productVariant.variantList)
          },
        ],
      ),
    );
  }
}

class GalleryContainer extends StatefulWidget {
  List<ProductImage> productImageList;
  String defultImage;
  int selecetedIndex = 0;
  GalleryContainer(
    this.defultImage,
    this.productImageList, {
    super.key,
  });

  @override
  State<GalleryContainer> createState() => _GalleryContainerState();
}

class _GalleryContainerState extends State<GalleryContainer> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44.0),
        child: Container(
          height: 284.0,
          decoration: BoxDecoration(
            color: CustomColors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 14.0, right: 14.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/icon_star.png'),
                    const Padding(
                      padding: EdgeInsets.only(top: 2.0, left: 3.0),
                      child: Text(
                        '4.8',
                        style: TextStyle(
                          fontFamily: 'sb',
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 180.0,
                      height: 180.0,
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: CashedImage(
                            imageUrl: (widget.productImageList.isEmpty)
                                ? widget.defultImage
                                : widget.productImageList[widget.selecetedIndex]
                                    .image,
                          )),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    const Spacer(),
                    Image.asset('assets/images/active_fav_product.png'),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 70.0,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 44.0, right: 44.0, top: 4.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.productImageList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            widget.selecetedIndex = index;
                          });
                        },
                        child: Container(
                          width: 70.0,
                          height: 70.0,
                          margin: const EdgeInsets.only(left: 20.0),
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: CustomColors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: widget.selecetedIndex == index
                                  ? CustomColors.blue
                                  : CustomColors.gery,
                              width: widget.selecetedIndex == index ? 2.0 : 1.5,
                            ),
                          ),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: CashedImage(
                              imageUrl: widget.productImageList[index].image,
                              radius: 10.0,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppBarProduct extends StatelessWidget {
  String productTitle;
  AppBarProduct(
    this.productTitle, {
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
                  productTitle,
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

class colorVariantList extends StatefulWidget {
  List<Variant> variantList;
  colorVariantList(this.variantList, {super.key});

  @override
  State<colorVariantList> createState() => _colorVariantListState();
}

class _colorVariantListState extends State<colorVariantList> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.variantList.length,
        itemBuilder: (context, index) {
          String productColor = 'ff${widget.variantList[index].value}';
          int hexColor = int.parse(productColor, radix: 16);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 32.0,
                  width: 32.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                        color: (_selectedIndex == index)
                            ? CustomColors.blueIndicator
                            : Colors.transparent,
                        width: 2.0),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Container(
                    height: 25.0,
                    width: 25.0,
                    decoration: BoxDecoration(
                      color: Color(hexColor),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class StorageVariantList extends StatefulWidget {
  List<Variant> storageVariantList;
  StorageVariantList(this.storageVariantList, {super.key});

  @override
  State<StorageVariantList> createState() => _StorageVariantListState();
}

class _StorageVariantListState extends State<StorageVariantList> {
  int _selecetedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.storageVariantList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                _selecetedIndex = index;
              });
            },
            child: Container(
              height: 25.0,
              margin: const EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: (_selecetedIndex == index)
                      ? Border.all(width: 2, color: CustomColors.blueIndicator)
                      : Border.all(width: 1, color: CustomColors.gery)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    widget.storageVariantList[index].value!,
                    style: const TextStyle(
                      fontFamily: 'sb',
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
