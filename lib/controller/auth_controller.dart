import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nowfood/manager/firebase_manager.dart';
import 'package:nowfood/view/login_page.dart';

import '../local/local_storage.dart';
import '../model/user_model.dart' as model;


class AuthenticateController extends GetxController with CacheManager {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  //late String userTypeController = 'Buyer';

  RxBool isLoggedIn = false.obs;
  Rx<bool> isObscure = true.obs;
  Rx<bool> isLoading = false.obs;

  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  void toggleVisibility() {
    isObscure.value = !isObscure.value;
  }

  void checkLoginStatus() {
    //final userType = getUserType();

   // if (userType == null || userType.isEmpty) {
      Get.off(const LoginPage());
/*     } else {
      if (userType == "Seller") {
        Get.offAll(const SellerHomeScreen());
      } else {
        Get.offAll(const BuyerHomeScreen());
      }
    } */
  }

  /* void toggleLoading({bool showMessage = false, String message = ''}) {
    isLoading.value = !isLoading.value;
    if (showMessage) {
      Utils.showSnackBar(
        message,
        isSuccess: false,
      );
    }
  } */

/*   void resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        'Success',
        'Password reset email is send successfully.',
      );
    } catch (err) {
      Get.snackbar(
        'Error',
        err.toString(),
      );
    }
  } */

 Future<bool> registerUser({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String address,
  }) async {
    try {
      if (registerFormKey.currentState!.validate()) {
        registerFormKey.currentState!.save();
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await firebaseAuth.currentUser!.sendEmailVerification();

        model.User user = model.User(
          name: name,
          uid: cred.user!.uid,
          phone: phone,
          email: email,
          profilePhoto: "",
          address: address,
        );

        await firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());

        removeToken();
       // toggleLoading();

        Get.snackbar(
          'Account created successfully!',
          'Please verify account to proceed.',
        );
        return true;
      }
      return false;
    } catch (e) {
     // toggleLoading();
      Get.snackbar(
        'Error Logging in',
        e.toString(),
      );
      return false;
    }
  }

 Future<bool> login(String email, String password, String userType) async {
    try {
      if (loginFormKey.currentState!.validate()) {
        loginFormKey.currentState!.save();

        UserCredential userCredential = await firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password);

        User? user = userCredential.user;

        if (user != null) {
          if (user.emailVerified) {
            setUserType(userType);
            clearfields();
            checkLoginStatus();
            return true;
          } else {
            Get.snackbar(
              'Error Logging in',
              'Please verify your email to login.',
            );
            return true;
          }
        } else {
          Get.snackbar(
            'Error Logging in',
            'Invalid email or password.',
          );
          return false;
        }
      }
      return false;
    } catch (err) {
      Get.snackbar(
        'Error Logging in',
        err.toString(),
      );
      return false;
    }
  }

  void logout() async {
    removeToken();
    await firebaseAuth.signOut();
  }

  void clearfields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
    addressController.clear();
   // userTypeController = 'Buyer';
  }
}
