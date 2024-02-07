import 'package:flutter/material.dart';
import 'package:shaparak/constans/color.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.blue,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/icon_application.png',
                        width: 100.0,
                        height: 100.0,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Text(
                        'شاپرک شاپ',
                        style: TextStyle(
                          fontFamily: 'sb',
                          fontSize: 24.0,
                          color: CustomColors.backgroundScreenColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: CustomColors.blue,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
                color: CustomColors.backgroundScreenColor,
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'نام کابری',
                        labelStyle: const TextStyle(
                          fontFamily: 'sm',
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                        // focusedBorder
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 3.0,
                            color: CustomColors.blueIndicator,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        // enabledBorder
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2.0,
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // password
                    TextField(
                      decoration: InputDecoration(
                        // focusedBorder
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 3.0,
                            color: CustomColors.blueIndicator,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: 'رمز عبور',
                        labelStyle: const TextStyle(
                          fontFamily: 'sm',
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                        // enabledBorder
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2.0,
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                          fontFamily: 'sb',
                          fontSize: 20.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        backgroundColor: CustomColors.blueIndicator,
                        minimumSize: const Size(200.0, 48.0),
                      ),
                      onPressed: () {},
                      child: const Text('ورود'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
