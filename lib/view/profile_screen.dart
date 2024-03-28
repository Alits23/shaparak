import 'package:flutter/material.dart';
import 'package:shaparak/util/auth_manager.dart';
import 'package:shaparak/view/login_screen.dart';
import '../constans/color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            const AppBarProfile(),
            const InfoUser(),
            ElevatedButton(
                onPressed: () {
                  AuthManager.logout();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                },
                child: const Text('خروج ')),
            const Wrap(
              spacing: 20.0,
              runSpacing: 20.0,
              alignment: WrapAlignment.end,
              children: [
                ItemList(),
                ItemList(),
                ItemList(),
                ItemList(),
                ItemList(),
                ItemList(),
                ItemList(),
                ItemList(),
                ItemList(),
                ItemList(),
                ItemList(),
                ItemList(),
                ItemList(),
              ],
            ),
            Spacer(),
            Text(
              'Shaparak Shop',
              style: TextStyle(
                fontFamily: 'sm',
                fontSize: 12.0,
                color: CustomColors.gery,
              ),
            ),
            Text(
              'v -2.2.04',
              style: TextStyle(
                fontFamily: 'sm',
                fontSize: 12.0,
                color: CustomColors.gery,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
            color: CustomColors.blueIndicator,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: const [
              BoxShadow(
                blurRadius: 25.0,
                color: CustomColors.blueIndicator,
                spreadRadius: -12.0,
                offset: Offset(0.0, 15.0),
              ),
            ],
          ),
          child: const Icon(
            Icons.settings,
            color: CustomColors.white,
            size: 35.0,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Text(
          'تنظیمات',
          style: TextStyle(
            fontFamily: 'sb',
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class InfoUser extends StatelessWidget {
  const InfoUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'علی تشکری صباغ',
          style: TextStyle(
            fontFamily: 'sb',
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '# 99154028',
          style: TextStyle(
            fontFamily: 'sm',
            fontSize: 14,
            color: CustomColors.gery,
          ),
        ),
        SizedBox(
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
