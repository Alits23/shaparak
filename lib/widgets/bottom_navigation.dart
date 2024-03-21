import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaparak/bloc/auth/auth_bloc.dart';
import 'package:shaparak/bloc/card/card_bloc.dart';
import 'package:shaparak/bloc/category/category_bloc.dart';
import 'package:shaparak/bloc/home/home_bloc.dart';
import 'package:shaparak/bloc/home/home_event.dart';
import 'package:shaparak/constans/color.dart';
import 'package:shaparak/view/card_screen.dart';
import 'package:shaparak/view/category_screen.dart';
import 'package:shaparak/view/home_screen.dart';
import 'package:shaparak/view/login_screen.dart';

import '../bloc/card/card_event.dart';
import '../di/di.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedIndex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          // login screen
          BlocProvider(
            create: (context) => AuthBloc(),
            child: LoginScreen(),
          ),
          // category screen
          BlocProvider(
            create: (context) => CategoryBloc(),
            child: const Categoryscreen(),
          ),
          //card screen
          BlocProvider(
            create: ((context) {
              var bloc = locator.get<CardBloc>();
              bloc.add(CardRequestDataEvent());
              return bloc;
            }),
            child: CardScreen(),
          ),
          //home screen
          BlocProvider(
            create: (context) {
              var bloc = HomeBloc();
              bloc.add(HomeRequestList());
              return bloc;
            },
            child: const HomeScreen(),
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            selectedLabelStyle: const TextStyle(
              fontFamily: 'sb',
              fontSize: 12.0,
              color: CustomColors.blue,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'sb',
              fontSize: 10.0,
              color: Colors.black,
            ),
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            items: [
              // 0
              BottomNavigationBarItem(
                icon: Container(
                  child: Image.asset('assets/images/icon_profile.png'),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: CustomColors.blueIndicator,
                        blurRadius: 20.0,
                        spreadRadius: -7.0,
                        offset: Offset(0.0, 13.0),
                      ),
                    ],
                  ),
                ),
                activeIcon:
                    Image.asset('assets/images/icon_profile_active.png'),
                label: 'پروفایل',
              ),
              // 1
              BottomNavigationBarItem(
                icon: Container(
                  child: Image.asset('assets/images/icon_category.png'),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: CustomColors.blueIndicator,
                        blurRadius: 20.0,
                        spreadRadius: -7.0,
                        offset: Offset(0.0, 13.0),
                      ),
                    ],
                  ),
                ),
                activeIcon:
                    Image.asset('assets/images/icon_category_active.png'),
                label: 'دسته بندی',
              ),
              // 2
              BottomNavigationBarItem(
                icon: Container(
                  child: Image.asset('assets/images/icon_basket.png'),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: CustomColors.blueIndicator,
                        blurRadius: 20.0,
                        spreadRadius: -7.0,
                        offset: Offset(0.0, 13.0),
                      ),
                    ],
                  ),
                ),
                activeIcon: Image.asset('assets/images/icon_basket_active.png'),
                label: 'سبدخرید',
              ),
              // 3
              BottomNavigationBarItem(
                icon: Container(
                  child: Image.asset('assets/images/icon_home.png'),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: CustomColors.blueIndicator,
                        blurRadius: 20.0,
                        spreadRadius: -7.0,
                        offset: Offset(0.0, 13.0),
                      ),
                    ],
                  ),
                ),
                activeIcon: Image.asset('assets/images/icon_home_active.png'),
                label: 'صفحه اصلی',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
