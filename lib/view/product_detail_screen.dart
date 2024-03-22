import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaparak/bloc/card/card_bloc.dart';
import 'package:shaparak/bloc/card/card_event.dart';
import 'package:shaparak/bloc/comment/comment_bloc.dart';
import 'package:shaparak/bloc/comment/comment_event.dart';
import 'package:shaparak/bloc/comment/comment_state.dart';
import 'package:shaparak/bloc/product_detail/product_detail_bloc.dart';
import 'package:shaparak/bloc/product_detail/product_detail_event.dart';
import 'package:shaparak/bloc/product_detail/product_detail_state.dart';
import 'package:shaparak/constans/color.dart';
import 'package:shaparak/data/model/comment.dart';
import 'package:shaparak/data/model/product.dart';
import 'package:shaparak/data/model/product_image.dart';
import 'package:shaparak/data/model/product_variant.dart';
import 'package:shaparak/data/model/properties.dart';
import 'package:shaparak/data/model/variant.dart';
import 'package:shaparak/data/model/variant_type.dart';
import 'package:shaparak/di/di.dart';
import 'package:shaparak/widgets/cashed_image.dart';
import 'package:shaparak/widgets/loading_animation.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen(this.product, {super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var bloc = ProductBloc();
        bloc.add(
            ProductRequestList(widget.product.id, widget.product.category));
        return bloc;
      },
      child: DetailScreenContent(widget.product, parentWidget: widget),
    );
  }
}

class DetailScreenContent extends StatelessWidget {
  final Product product;
  final ProductDetailScreen parentWidget;
  const DetailScreenContent(
    this.product, {
    super.key,
    required this.parentWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return const Center(child: LoadingAnimation());
          }
          return SafeArea(
            child: CustomScrollView(
              slivers: [
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
                    return AppBarProduct(productCategory.title);
                  })
                },
                if (state is ProductResponseState) ...{
                  SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          parentWidget.product.name,
                          style: const TextStyle(
                            fontFamily: 'sb',
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                },
                if (state is ProductResponseState) ...{
                  state.productImages.fold((l) {
                    return SliverToBoxAdapter(
                      child: Text(l),
                    );
                  }, (imageList) {
                    return GalleryContainer(
                      parentWidget.product.thumbnail,
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
                if (state is ProductResponseState) ...{
                  state.productProperties.fold((l) {
                    return SliverToBoxAdapter(
                      child: Text(l),
                    );
                  }, (propertyList) {
                    return ProductProperties(propertyList);
                  })
                },
                if (state is ProductResponseState) ...{
                  InfoProduct(parentWidget.product.description),
                },
                if (state is ProductResponseState) ...{
                  UsersComment(product: product),
                },
                if (state is ProductResponseState) ...{
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PriceTagButton(product),
                          const SizedBox(
                            width: 5.0,
                          ),
                          AddToBasketButton(parentWidget.product),
                        ],
                      ),
                    ),
                  ),
                },
              ],
            ),
          );
        },
      ),
    );
  }
}

class PriceTagButton extends StatelessWidget {
  final Product product;
  const PriceTagButton(
    this.product, {
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${product.price}',
                          style: const TextStyle(
                            color: CustomColors.white,
                            fontFamily: 'sm',
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          '${product.realPrice}',
                          style: const TextStyle(
                            color: CustomColors.white,
                            fontFamily: 'sm',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        height: 20,
                        width: 42,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          color: Colors.red,
                        ),
                        child: Text(
                          '${product.persent!.toInt()} %',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
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
  final Product product;
  const AddToBasketButton(
    this.product, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<ProductBloc>().add(ProductAddToBasket(product));
        context.read<CardBloc>().add(CardRequestDataEvent());
      },
      child: Stack(
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
      ),
    );
  }
}

class UsersComment extends StatefulWidget {
  final Product product;
  const UsersComment({
    super.key,
    required this.product,
  });

  @override
  State<UsersComment> createState() => _UsersCommentState();
}

class _UsersCommentState extends State<UsersComment> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 44.0, right: 44.0),
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return BlocProvider(
                  create: (context) {
                    CommentBloc(locator.get());
                    final bloc = CommentBloc(locator.get());
                    bloc.add(CommentRequestList(widget.product.id));
                    return bloc;
                  },
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.5,
                    minChildSize: 0.2,
                    maxChildSize: 0.7,
                    builder: (context, scrollController) {
                      return CommentBottomSheet(scrollController);
                    },
                  ),
                );
              },
            );
          },
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
      ),
    );
  }
}

class CommentBottomSheet extends StatelessWidget {
  final ScrollController controller;
  const CommentBottomSheet(
    this.controller, {
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state is CommentLoadingState) {
          return const Center(
            child: LoadingAnimation(),
          );
        }
        return CustomScrollView(
          controller: controller,
          slivers: [
            if (state is CommentResponseState) ...{
              state.getComment.fold((l) {
                return SliverToBoxAdapter(
                  child: Text(l),
                );
              }, (commentList) {
                if (commentList.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text('نظری ثبت نشده است'),
                    ),
                  );
                }
                return SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: commentList.length, (context, index) {
                  return Text(commentList[index].text);
                }));
              })
            }
          ],
        );
      },
    );
  }
}

// InfoProduct

class InfoProduct extends StatefulWidget {
  final String productDescription;
  const InfoProduct(
    this.productDescription, {
    super.key,
  });

  @override
  State<InfoProduct> createState() => _InfoProductState();
}

class _InfoProductState extends State<InfoProduct> {
  bool _visibleInfo = false;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 44.0, right: 44.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _visibleInfo = !_visibleInfo;
                });
              },
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
                    (_visibleInfo)
                        ? Image.asset('assets/images/icon_down_categroy.png')
                        : Image.asset('assets/images/icon_left_categroy.png'),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'مشاهده',
                      style: TextStyle(
                          fontFamily: 'sm',
                          fontSize: 12,
                          color: CustomColors.blue),
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
          ),
          Visibility(
            visible: _visibleInfo,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 24.0, left: 44.0, right: 44.0),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  width: 1,
                  color: CustomColors.gery,
                ),
              ),
              child: Text(
                widget.productDescription,
                textAlign: TextAlign.right,
                style: const TextStyle(
                    fontFamily: 'sm', fontSize: 16.0, height: 1.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductProperties extends StatefulWidget {
  final List<Properties> productPropertiesList;
  const ProductProperties(
    this.productPropertiesList, {
    super.key,
  });

  @override
  State<ProductProperties> createState() => _ProductPropertiesState();
}

class _ProductPropertiesState extends State<ProductProperties> {
  bool _visiblePorperty = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 44.0, right: 44.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _visiblePorperty = !_visiblePorperty;
                });
              },
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
                    (_visiblePorperty)
                        ? Image.asset('assets/images/icon_down_categroy.png')
                        : Image.asset('assets/images/icon_left_categroy.png'),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'مشاهده',
                      style: TextStyle(
                          fontFamily: 'sm',
                          fontSize: 12,
                          color: CustomColors.blue),
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
          ),
          Visibility(
            visible: _visiblePorperty,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 24.0, left: 44.0, right: 44.0),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  width: 1,
                  color: CustomColors.gery,
                ),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.productPropertiesList.length,
                itemBuilder: (context, index) {
                  return Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Flexible(
                        child: Text(
                          '${widget.productPropertiesList[index].value} : ${widget.productPropertiesList[index].title}',
                          style: const TextStyle(
                            fontFamily: 'sm',
                            fontSize: 14.0,
                            height: 1.8,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VariantContainerGenerator extends StatelessWidget {
  final List<ProductVariant> productVariantList;
  const VariantContainerGenerator(
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
  final ProductVariant productVariant;
  const VariantgeneratorChild(this.productVariant, {super.key});

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
            ColorVariantList(productVariant.variantList)
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
  final List<ProductImage> productImageList;
  final String defultImage;

  const GalleryContainer(
    this.defultImage,
    this.productImageList, {
    super.key,
  });

  @override
  State<GalleryContainer> createState() => _GalleryContainerState();
}

class _GalleryContainerState extends State<GalleryContainer> {
  int selecetedIndex = 0;
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
                                : widget.productImageList[selecetedIndex].image,
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
                            selecetedIndex = index;
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
                              color: selecetedIndex == index
                                  ? CustomColors.blue
                                  : CustomColors.gery,
                              width: selecetedIndex == index ? 2.0 : 1.5,
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
  final String productTitle;
  const AppBarProduct(
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

class ColorVariantList extends StatefulWidget {
  final List<Variant> variantList;
  const ColorVariantList(this.variantList, {super.key});

  @override
  State<ColorVariantList> createState() => _ColorVariantListState();
}

class _ColorVariantListState extends State<ColorVariantList> {
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
  final List<Variant> storageVariantList;
  const StorageVariantList(this.storageVariantList, {super.key});

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
