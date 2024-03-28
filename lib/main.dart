import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shaparak/bloc/auth/auth_bloc.dart';
import 'package:shaparak/data/model/basket_item.dart';
import 'package:shaparak/util/auth_manager.dart';
import 'package:shaparak/view/login_screen.dart';
import 'package:shaparak/widgets/bottom_navigation.dart';

import 'di/di.dart';

GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BasketItemAdapter());
  await Hive.openBox<BasketItem>('BasketItem');
  await getInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //for navigate without doesn't matter  were are you
      navigatorKey: globalNavigatorKey,
      debugShowCheckedModeBanner: false,
      home: (AuthManager.readAuth().isEmpty)
          ? LoginScreen()
          : const BottomNavigation(),
    );
  }
}
