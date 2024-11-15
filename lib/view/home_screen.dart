import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaparak/bloc/home/home_bloc.dart';
import 'package:shaparak/bloc/home/home_event.dart';
import 'package:shaparak/bloc/home/home_state.dart';
import 'package:shaparak/bloc/product_list/product_list_bloc.dart';
import 'package:shaparak/constans/color.dart';
import 'package:shaparak/data/model/category.dart';
import 'package:shaparak/data/model/product.dart';
import 'package:shaparak/view/best_seller_screen.dart';
import 'package:shaparak/view/most_view.dart';
import 'package:shaparak/widgets/category_items.dart';
import 'package:shaparak/widgets/loading_animation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../data/model/banner.dart';
import '../widgets/cashed_image.dart';
import '../widgets/product_container.dart';

List<Product> mostviewList = [];
List<Product> bestSellerList = [];
ValueNotifier<bool> isLight = ValueNotifier(true);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isLight,
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: isLight.value
              ? CustomColors.backgroundScreenColor
              : CustomColors.backgroundScreenColorDark,
          body: SafeArea(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return state is HomeLoadingState
                    ? const Center(
                        child: LoadingAnimation(),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          context.read<HomeBloc>().add(HomeRequestList());
                        },
                        child: CustomScrollView(
                          slivers: [
                            const AppBar(),
                            if (state is HomeResponseState) ...{
                              state.bannerlist.fold((l) {
                                return SliverToBoxAdapter(
                                  child: Center(child: Text(l)),
                                );
                              }, (r) {
                                return BannerSlider(r);
                              })
                            },
                            const CategoryListTitle(),
                            if (state is HomeResponseState) ...{
                              state.categoryList.fold((l) {
                                return SliverToBoxAdapter(
                                  child: Center(child: Text(l)),
                                );
                              }, (r) {
                                return CategoryList(r);
                              })
                            },
                            const MostViewTitle(),
                            if (state is HomeResponseState) ...{
                              state.productListHotest.fold((l) {
                                return SliverToBoxAdapter(
                                  child: Center(child: Text(l)),
                                );
                              }, (r) {
                                mostviewList = r;
                                return MostViewProductList(r);
                              })
                            },
                            const BestSellerTitle(),
                            if (state is HomeResponseState) ...{
                              state.productListBestSeller.fold((l) {
                                return SliverToBoxAdapter(
                                  child: Center(child: Text(l)),
                                );
                              }, (r) {
                                bestSellerList = r;
                                return BestSellerProductList(r);
                              })
                            }
                          ],
                        ),
                      );
              },
            ),
          ),
        );
      },
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({
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
              const Spacer(),
              Expanded(child: Image.asset('assets/images/icon_app.png')),
              const Spacer(),
              ValueListenableBuilder(
                valueListenable: isLight,
                builder: (context, value, child) {
                  return IconButton(
                    icon: Icon(
                      isLight.value
                          ? Icons.light_mode_outlined
                          : Icons.dark_mode,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BannerSlider extends StatelessWidget {
  final List<BannerCampaign> listBanner;
  const BannerSlider(this.listBanner, {super.key});

  @override
  Widget build(BuildContext context) {
    final bannerController = PageController(
        viewportFraction: 0.8, keepPage: true, initialPage: listBanner.length);
    return SliverToBoxAdapter(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: 177.0,
            child: PageView.builder(
              controller: bannerController,
              itemCount: listBanner.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CashedImage(
                    radius: 15.0,
                    imageUrl: listBanner[index].thumbnail,
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 10.0,
            child: SmoothPageIndicator(
              controller: bannerController,
              count: listBanner.length,
              effect: const ExpandingDotsEffect(
                activeDotColor: CustomColors.blueIndicator,
                dotColor: CustomColors.white,
                expansionFactor: 4.0,
                dotHeight: 9.0,
                dotWidth: 9.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryListTitle extends StatelessWidget {
  const CategoryListTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(right: 44, left: 44, bottom: 20, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'دسته بندی ها',
              style: TextStyle(
                fontFamily: 'sb',
                color: CustomColors.gery,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  final List<Category> listCategory;
  const CategoryList(this.listCategory, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 88.0,
        child: ListView.builder(
          reverse: true,
          padding: const EdgeInsets.only(right: 44.0),
          scrollDirection: Axis.horizontal,
          itemCount: listCategory.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: CategoryItems(listCategory[index]),
            );
          },
        ),
      ),
    );
  }
}

class MostViewTitle extends StatelessWidget {
  const MostViewTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
            right: 44.0, left: 44.0, bottom: 20.0, top: 63.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => ProductListBloc(),
                      child: MostviewScreen(
                        productList: mostviewList,
                      ),
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Image.asset('assets/images/icon_left_categroy.png'),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'مشاهده همه',
                    style: TextStyle(
                      fontFamily: 'sb',
                      color: CustomColors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Text(
              'پربازدید ترین ها',
              style: TextStyle(
                fontFamily: 'sb',
                color: CustomColors.gery,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MostViewProductList extends StatelessWidget {
  final List<Product> productList;
  const MostViewProductList(
    this.productList, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200.0,
        child: ListView.builder(
          reverse: true,
          padding: const EdgeInsets.only(right: 44.0),
          scrollDirection: Axis.horizontal,
          itemCount: productList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ProductContainer(productList[index]),
            );
          },
        ),
      ),
    );
  }
}

class BestSellerTitle extends StatelessWidget {
  const BestSellerTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(right: 44, left: 44, bottom: 20, top: 32),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => ProductListBloc(),
                      child: BestSellerScreen(
                        productList: bestSellerList,
                      ),
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Image.asset('assets/images/icon_left_categroy.png'),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'مشاهده همه',
                    style: TextStyle(
                      fontFamily: 'sb',
                      color: CustomColors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Text(
              'پرفروش ترین ها',
              style: TextStyle(
                fontFamily: 'sb',
                color: CustomColors.gery,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BestSellerProductList extends StatelessWidget {
  final List<Product> productList;
  const BestSellerProductList(
    this.productList, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: SizedBox(
          height: 200.0,
          child: ListView.builder(
            reverse: true,
            padding: const EdgeInsets.only(right: 44.0),
            scrollDirection: Axis.horizontal,
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ProductContainer(productList[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void toggleTheme() {
    if (state == ThemeMode.light) {
      isLight.value = false;
      emit(ThemeMode.dark);
    } else {
      isLight.value = true;
      emit(ThemeMode.light);
    }
  }
}
