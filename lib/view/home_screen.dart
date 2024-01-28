import 'package:flutter/material.dart';
import 'package:shaparak/constans/color.dart';
import 'package:shaparak/widgets/banner_slider.dart';
import 'package:shaparak/widgets/category_items.dart';
import '../widgets/product_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            AppBar(),
            BannersList(),
            CategoryListTitle(),
            CategoryList(),
            MostViewTitle(),
            MostViewProductList(),
            BestSellerTitle(),
            BestSellerProductList(),
          ],
        ),
      ),
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
              const SizedBox(
                width: 10.0,
              ),
              const Expanded(
                child: Text(
                  'جستجوی محصولات',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontFamily: 'sb',
                    color: CustomColors.gery,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Image.asset('assets/images/icon_search.png'),
              const SizedBox(
                width: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BannersList extends StatelessWidget {
  const BannersList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: BannerSlider(),
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
  const CategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 88.0,
        child: ListView.builder(
          reverse: true,
          padding: const EdgeInsets.only(right: 44.0),
          scrollDirection: Axis.horizontal,
          itemCount: 20,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: CategoryItems(),
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
  const MostViewProductList({
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
          itemCount: 20,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: ProductContainer(),
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
  const BestSellerProductList({
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
          itemCount: 5,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: ProductContainer(),
            );
          },
        ),
      ),
    );
  }
}
