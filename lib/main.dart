import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shaparak/data/model/basket_item.dart';
import 'package:shaparak/util/auth_manager.dart';
import 'package:shaparak/view/home_screen.dart';
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
  runApp(
    BlocProvider(
      create: (context) => ThemeCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          //for navigate without doesn't matter where you are
          navigatorKey: globalNavigatorKey,
          debugShowCheckedModeBanner: false,

          // Define light theme
          themeMode: themeMode,
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
          ),

          // Define dark theme
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.deepPurple,
          ),

          home: (AuthManager.readAuth().isEmpty)
              ? LoginScreen()
              : const BottomNavigation(),
        );
      },
    );
  }
}
