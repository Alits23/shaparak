import 'package:flutter/material.dart';
import 'package:shaparak/util/auth_manager.dart';
import 'package:shaparak/view/home_screen.dart';
import 'package:shaparak/view/login_screen.dart';
import '../constans/color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLight.value
          ? CustomColors.backgroundScreenColor
          : CustomColors.backgroundScreenColorDark,
      body: SafeArea(
        child: Column(
          children: [
            const AppBarProfile(),
            const InfoUser(),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.red,
              ),
              onPressed: () {
                AuthManager.logout();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
              child: const Text(
                'خروج از حساب کاربری',
                style: TextStyle(
                  color: CustomColors.white,
                  fontFamily: 'dana',
                ),
              ),
            ),
            const Text(
              'Shaparak Shop',
              style: TextStyle(
                fontFamily: 'sm',
                fontSize: 12.0,
                color: CustomColors.gery,
              ),
            ),
            const Text(
              'v -2.2.04',
              style: TextStyle(
                fontFamily: 'sm',
                fontSize: 12.0,
                color: CustomColors.gery,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}

class InfoUser extends StatelessWidget {
  const InfoUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: Image.asset('assets/images/avatar.png'),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          AuthManager.getUsername(),
          style: TextStyle(
              fontFamily: 'sb',
              fontSize: 20,
              color: isLight.value
                  ? CustomColors.backgroundScreenColorDark
                  : CustomColors.backgroundScreenColor),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          AuthManager.getUserId(),
          style: const TextStyle(
            fontFamily: 'sm',
            fontSize: 14,
            color: CustomColors.gery,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

class AppBarProfile extends StatelessWidget {
  const AppBarProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            const Expanded(
              child: Text(
                'حساب کاربری',
                textAlign: TextAlign.center,
                style: TextStyle(
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
    );
  }
}
