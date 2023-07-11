import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nowfood/view/User/Get%20Food/get_food_page.dart';
import 'package:nowfood/view/User/user_home_page.dart';
import 'package:nowfood/view/login_page.dart';
import 'package:nowfood/view/splashscreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:  const Splash(),
       routes: {
        '/login': (context) => const Login(), // Example route for the home screen
      },
    );
  }
}
  