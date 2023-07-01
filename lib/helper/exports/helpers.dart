import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nowfood/widgets/custom_text.dart';
import 'package:nowfood/widgets/toast.dart';
import 'package:nowfood/manager/values_manager.dart';
import 'package:nowfood/manager/fonts_manager.dart';

class Helpers {
  Helpers._();
  static showLoading(BuildContext context) {
    //final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Get.defaultDialog(
      title: '',
      backgroundColor: Colors.white,
      content: customLoading(context),
      radius: RadiusManager.buttonRadius,
      barrierDismissible: false,
    );
  }

  static Widget customLoading(BuildContext context) {
   // final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: Colors.black,
      child: const 
      Center(
        child: Column(
          children: [
             SizedBox(height: 10),
            Txt(
              textAlign: TextAlign.center,
              text: 'Your order is proceeding...',
              fontWeight: FontWeightManager.bold,
              fontSize: FontSize.titleFontSize * 0.8,
              color: Colors.black,
              fontFamily: FontsManager.fontFamilyPoppins,
            ),
      /*       SizedBox(
              height: 300,
              width: 300,
              child: Lottie.asset(
                'assets/lottie/logo.json',
                fit: BoxFit.contain,
              ),
            ), */
          ],
        ),
      ),
    );
  }

  static dismissLoadingWidget() {
    Get.back();
  }

  static void showSnackBar(
    String message, {
    isSuccess = true,
    String? title,
    Icon? icon,
  }) =>
      Get.showSnackbar(
        GetSnackBar(
          icon: icon ??
              Icon(
                isSuccess ? Icons.check_circle_rounded : Icons.cancel_rounded,
                color:
                    isSuccess ? Colors.black : Colors.green,
                size: SizeManager.sizeM,
              ),
          titleText: Text(
            title ?? isSuccess ? "Success" : "Failed",
            style: TextStyle(
              fontSize: FontSize.subTitleFontSize,
              color: isSuccess ? Colors.black : Colors.green,
              fontWeight: FontWeight.w700,
              //fontFamily: "Nunito",
              letterSpacing: 1.0,
            ),
          ),
          messageText: Text(
            message,
            style: TextStyle(
              fontSize: FontSize.textFontSize,
              color: isSuccess ? Colors.black : Colors.green,
              fontWeight: FontWeight.w700,
              //fontFamily: "Nunito",
              letterSpacing: 1.0,
            ),
          ),
          duration: const Duration(seconds: 4),
        ),
      );

  static void showToast(BuildContext context, String message) =>
      Toast.show(message, context, duration: 5, gravity: 2);
}
