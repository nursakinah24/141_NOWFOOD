import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowfood/controller/auth_controller.dart';
import 'package:nowfood/controller/get_food_controller.dart';
import 'package:nowfood/manager/values_manager.dart';
import 'package:nowfood/view/User/history_page.dart';
import 'package:nowfood/view/User/pending_page.dart';
import 'package:nowfood/widgets/Custom/custom_text.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({super.key});

  //final AuthController controller;

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
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
                icon: const Icon(Icons.pending_actions),
                onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PendingPage(),
                        ),
                      );
                },
              ),
              const Txt(text: 'Pending'),
            ],
          ),
          const SizedBox(
            height: SizeManager.sizeSemiM,
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.history),
              onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HistoryPage(),
                        ),
                      );
                },
              ),
              const Txt(text: 'History'),
            ],
          ),
          const SizedBox(
            height: SizeManager.sizeL,
          ),
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
