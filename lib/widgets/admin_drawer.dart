import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowfood/controller/auth_controller.dart';
import 'package:nowfood/controller/get_food_controller.dart';
import 'package:nowfood/widgets/Custom/custom_text.dart';

class AdminDrawer extends StatefulWidget {
  const AdminDrawer({super.key});

  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  /* final gfController = Get.put(GetFoodController());
  final Controller = Get.put(GetFoodController()); */
  final AuthController authCtrl = AuthController();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
          child: Column(
        children: [
           Row(
            children: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  authCtrl.signOut(context);
                },
              ),
              const Txt(text: 'Logout'),
            ],
          )
        ],
      )),
    );
  }
}
