import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowfood/widgets/text_form_field.dart';
import 'package:nowfood/widgets/button.dart';
import 'package:nowfood/widgets/text.dart';

import '../controller/auth_controller.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticateController auth_controller = Get.put(AuthenticateController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20.0),
              child: Form(
                key: auth_controller.registerFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: const TextSpan(
                          text: 'Register!',
                          style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(27, 94, 32, 1)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    CustomTextFormField(
                      controller: auth_controller.nameController,
                      labelText: "Input your name",
                      autofocus: false,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      prefixIconData: Icons.person,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter your name';
                        }
                        return null;
                      },
                      /*  decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'Input your name',
                          labelText: 'Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter your name';
                        }
                        return null;
                      }, */
                    ),
                    const SizedBox(
                      height: 14.0,
                    ),
                    CustomTextFormField(
                      controller: auth_controller.phoneController,
                      labelText: 'Input your phone number',
                      autofocus: false,
                      //hintText: StringsManager.phoneHintTxt,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      prefixIconData: Icons.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14.0),
                    CustomTextFormField(
                      controller: auth_controller.emailController,
                      labelText: 'Input your email address',
                      autofocus: false,
                      // hintText: StringsManager.emailHintTxt,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      prefixIconData: Icons.email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter your email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 14.0,
                    ),
                    CustomTextFormField(
                      controller: auth_controller.addressController,
                      labelText: 'Input your address',
                      autofocus: false,
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.next,
                      prefixIconData: Icons.home,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter your address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 14.0,
                    ),
                    /*  TextFormField(
                      controller: auth_controller.passwordController,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.password),
                          hintText: 'Your Password',
                          labelText: 'Password'),
                      obscureText: auth_controller.isObscure.value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter a valid password';
                        }
                        return null;
                      },
                    ), */
                    Obx(
                      () => CustomTextFormField(
                        controller: auth_controller.passwordController,
                        autofocus: false,
                        labelText: 'Input your password',
                        obscureText: auth_controller.isObscure.value,
                        prefixIconData: Icons.vpn_key_rounded,
                        suffixIconData: auth_controller.isObscure.value
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        onSuffixTap: auth_controller.toggleVisibility,
                        textInputAction: TextInputAction.done,
                        onFieldSubmit: (_) async {
                          final isValid = await auth_controller.registerUser(
                            email: auth_controller.emailController.text,
                            name: auth_controller.nameController.text,
                            password: auth_controller.passwordController.text,
                            phone: auth_controller.phoneController.text,
                            address: auth_controller.addressController.text,
                          );
                          await auth_controller.removeToken();
                          if (isValid) {
                            firstTimeLoginDialog(auth_controller);
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Passwords must not be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 18.0,
                    ),
                    Obx(
                      () => CustomButton(
                        color: Colors.green.shade900,
                        hasInfiniteWidth: true,
                        loadingWidget: auth_controller.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  backgroundColor:
                                      Color.fromRGBO(255, 248, 225, 1),
                                ),
                              )
                            : null,
                        onPressed: () async {
                          final isValid = await auth_controller.registerUser(
                            email: auth_controller.emailController.text,
                            name: auth_controller.nameController.text,
                            password: auth_controller.passwordController.text,
                            phone: auth_controller.phoneController.text,
                            address: auth_controller.addressController.text,
                          );
                          await auth_controller.removeToken();
                          if (isValid) {
                            firstTimeLoginDialog(auth_controller);
                          }
                        },
                        text: 'Register',
                        textColor: Colors.white,
                        buttonType: ButtonType.loading,
                      ),
                    ),
                    const SizedBox(
                      height: 18.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: const TextSpan(
                              text: 'Already have an account?',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            auth_controller.clearfields();
                            Get.offAll(const LoginPage());
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: const TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> firstTimeLoginDialog(AuthenticateController controller) {
    return Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: const Txt(
            text: 'First login to Proceed',
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          content: const Txt(
            text: 'First login to Proceed',
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.logout();
                controller.clearfields();
                Get.offAll(const LoginPage());
              },
              child: const Txt(
                text: 'Login',
                color: Color.fromRGBO(27, 94, 32, 1),
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
