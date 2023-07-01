import 'package:flutter/material.dart';
import 'package:nowfood/controller/auth_controller.dart';
import 'package:nowfood/manager/fonts_manager.dart';
import 'package:nowfood/manager/values_manager.dart';
import 'package:nowfood/model/user_model.dart';
import 'package:nowfood/view/admin_page.dart';
import 'package:nowfood/view/register_page.dart';
import 'package:nowfood/view/home_page.dart';
import 'package:nowfood/widgets/custom_text_form_field.dart';
import 'package:nowfood/widgets/custom_text.dart';
import 'package:nowfood/widgets/custom_button.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final form = GlobalKey<FormState>();

  final authCtrl = AuthController();

  String? email;

  String? password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
          child: SingleChildScrollView(
              child: Container(
        margin: const EdgeInsets.symmetric(
            vertical: MarginManager.marginXL,
            horizontal: MarginManager.marginXL),
        child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/logo.png",
                  height: SizeManager.imageSize,
                  width: SizeManager.imageSize,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const Txt(
                  text: 'Welcome back!',
                  textAlign: TextAlign.left,
                  color: Colors.black,
                  fontWeight: FontWeightManager.bold,
                  fontSize: FontSize.titleFontSize,
                ),
              ),
              const SizedBox(
                height: SizeManager.sizeXL,
              ),
              CustomTextFormField(
                labelText: 'Email Address',
                autofocus: false,
                hintText: 'abc@gmail.com',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                prefixIconData: Icons.email,
                onChanged: (value) {
                  email = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: SizeManager.sizeSemiM,
              ),
              CustomTextFormField(
                labelText: 'Password',
                autofocus: false,
                obscureText: true,
                prefixIconData: Icons.vpn_key_rounded,
                suffixIconData: Icons.visibility_rounded,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  password = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              /*  TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ), */
              const SizedBox(
                height: SizeManager.sizeM,
              ),
              CustomButton(
                color: Colors.green,
                hasInfiniteWidth: true,
                buttonType: ButtonType.loading,
                /*  loadingWidget: controller.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  backgroundColor:
                                      ColorsManager.scaffoldBgColor,
                                ),
                              )
                            : null, */
                onPressed: () async {
                  if (form.currentState!.validate()) {
                    if (email == 'admin@admin.com' && password == 'password') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminPage(),
                        ),
                      );
                      setState(() {});
                      // Perform admin login
                      // showToast('Admin login successful');
                      // Navigate to the admin home screen
                    } else {
                      UserModel? currentUser = await authCtrl
                          .signInWithEmailAndPassword(email!, password!);
                      if (currentUser != null) {
                        // ignore: use_build_context_synchronously
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const HomePage();
                        }));
                        // Login successful
                        /*             showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Login Successful'),
                            content: const Text(
                                'You have been successfully logged in.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return HomePage();
                                  }));
                                  // Navigate to the next screen or perform any desired action
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      ); */
                      } else {
                        // Login failed
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Login Failed'),
                              content: const Text('Invalid email or password.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  }
                },
                text: 'Login',
                textColor: Colors.black,
              ),
              const SizedBox(
                height: SizeManager.sizeL,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Txt(
                      text: 'Don\'t have an account? ',
                      fontSize: FontSize.textFontSize,
                      color: Colors.black),
                  InkWell(
                    onTap: () {
                      //controller.clearfields();
                      // Get.offAll(const SignupScreen());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Register(),
                        ),
                      );
                    },
                    child: const Txt(
                      text: 'Register',
                      fontSize: FontSize.textFontSize,
                      color: Colors.black,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                ],
              ),
             /*  TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Register();
                  }));
                },
                child: const Text('Create an account'),
              ), */
            ],
          ),
        ),
      ))),
    ));
  }
}
