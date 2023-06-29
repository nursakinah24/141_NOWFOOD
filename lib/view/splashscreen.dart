import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nowfood/view/login_page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
   // Timer(const Duration(seconds: 2), () => )
  }


@override
  Widget build(BuildContext context) {
    return SafeArea(
    child: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, children: [
             Image.asset("assets/images/logo.png"),
          ],)
          ),
    ));
  }
}
