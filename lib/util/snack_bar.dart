import 'package:flutter/material.dart';
import 'package:shaparak/constans/color.dart';

abstract class CustomSnackBar {
  // حالت موفق
  static void successSnackBar(BuildContext context, String title) {
    var snackBar = const SnackBarContainer(
      color: SNACKBAR_SUCCESS_COLOR,
      icon: Icon(
        Icons.check_circle_outline,
        color: CustomColors.green,
      ),
    ).snackBarStatus(context, title);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // حالت اخطار
  static void warningSnackBar(BuildContext context, String title) {
    var snackBar = const SnackBarContainer(
      color: SNACKBAR_WARNING_COLOR,
      icon: Icon(Icons.warning_amber_rounded),
    ).snackBarStatus(context, title);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // حالت ارور
  static void errorSnackBar(BuildContext context, String title) {
    var snackBar = const SnackBarContainer(
      color: SNACKBAR_ERROR_COLOR,
      icon: Icon(Icons.error),
    ).snackBarStatus(context, title);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

final class SnackBarContainer {
  final Color color;
  final Widget icon;
  const SnackBarContainer({
    required this.color,
    required this.icon,
  });
  SnackBar snackBarStatus(BuildContext context, String title) {
    var snackBar = SnackBar(
      content: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 40),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: color,
                        blurRadius: 150,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Container(
                    width: 32.0,
                    height: 32.0,
                    decoration: const BoxDecoration(
                      color: CustomColors.backgroundScreenColor,
                      shape: BoxShape.circle,
                    ),
                    child: FittedBox(
                      fit: BoxFit.none,
                      child: icon,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: -15,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: color,
                boxShadow: [
                  BoxShadow(
                    color: color,
                    spreadRadius: 1,
                    blurRadius: 2,
                  ),
                ],
                border: Border.all(
                  color: color,
                ),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          )
        ],
      ),
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      backgroundColor: CustomColors.green,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 5),
      dismissDirection: DismissDirection.horizontal,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 120,
        right: 10,
        left: 10,
      ),
    );
    return snackBar;
  }
}
