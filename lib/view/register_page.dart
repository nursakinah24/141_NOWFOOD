import 'package:flutter/material.dart';
import 'package:nowfood/controller/auth_controller.dart';
import 'package:nowfood/model/user_model.dart';
import 'package:nowfood/view/User/user_home_page.dart';
import 'package:nowfood/view/login_page.dart';
import 'package:nowfood/manager/fonts_manager.dart';
import 'package:nowfood/manager/values_manager.dart';
import 'package:nowfood/widgets/Custom/custom_text_form_field.dart';
import 'package:nowfood/widgets/Custom/custom_text.dart';
import 'package:nowfood/widgets/Custom/custom_button.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final form = GlobalKey<FormState>();

  final authCtrl = AuthController();

  String? name;

  String? email;

  String? password;

  String? address;

  String? phoneNumber;

  bool registrationSuccess = false;

  void showRegistrationSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Success'),
          content: const Text('You have been successfully registered.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate to the home page or login page
                // based on your app's navigation flow
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserHomePage()),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

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
                  "assets/images/reg.png",
                  height: SizeManager.imageSizeMed / 2,
                  width: SizeManager.imageSizeMed / 2,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const Txt(
                  text: 'Register',
                  textAlign: TextAlign.left,
                  color: Colors.black,
                  fontWeight: FontWeightManager.bold,
                  fontSize: FontSize.titleFontSize,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const Txt(
                  text: 'Create your account',
                  textAlign: TextAlign.left,
                  color: Colors.black,
                  fontWeight: FontWeightManager.medium,
                  fontSize: FontSize.subTitleFontSize * 1.3,
                ),
              ),
              const SizedBox(
                height: SizeManager.sizeXL,
              ),
              CustomTextFormField(
                labelText: 'Name',
                autofocus: false,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                prefixIconData: Icons.person,
                onChanged: ((value) {
                  name = value;
                }),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: SizeManager.sizeSemiM,
              ),
              CustomTextFormField(
                labelText: 'Phone Number',
                autofocus: false,
                hintText: '08xxxxxxxx',
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                prefixIconData: Icons.phone,
                onChanged: ((value) {
                  phoneNumber = value;
                }),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: SizeManager.sizeSemiM,
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
                    return 'Please enter an email address';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: SizeManager.sizeSemiM,
              ),
              CustomTextFormField(
                labelText: 'Address',
                autofocus: false,
                keyboardType: TextInputType.streetAddress,
                textInputAction: TextInputAction.next,
                prefixIconData: Icons.home,
                onChanged: ((value) {
                  address = value;
                }),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an address';
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
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: SizeManager.sizeM,
              ),
              CustomButton(
                color: Colors.green,
                hasInfiniteWidth: true,
                buttonType: ButtonType.loading,
                onPressed: () async {
                  if (form.currentState!.validate()) {
                    UserModel? registeredUser =
                        await authCtrl.registerWithEmailAndPassword(
                            email!, password!, name!, address!, phoneNumber!);
                    if (registeredUser != null) {
                      setState(() {
                        registrationSuccess = true;
                      });
                      showRegistrationSuccessDialog(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    } else {
                      // Failed
                      // ignore: use_build_context_synchronously
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Registration Failed'),
                              content: const Text(
                                  'An error occurred during registration.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          });
                    }
                  }
                },
                text: 'Register',
                textColor: Colors.white,
              ),
              const SizedBox(
                height: SizeManager.sizeL,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Txt(
                      text: 'Already have an account? ',
                      fontSize: FontSize.textFontSize,
                      color: Colors.black),
                  InkWell(
                    onTap: () {
                      //controller.clearfields();
                      // Get.offAll(const SignupScreen());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    },
                    child: const Txt(
                      text: 'Login',
                      fontSize: FontSize.textFontSize,
                      color: Colors.black,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ))),
    ));
  }
}
