import 'package:flutter/material.dart';
import 'package:nowfood/manager/values_manager.dart';
import 'package:nowfood/view/Admin/admin_get_food.dart';
import 'package:nowfood/view/Admin/admin_save_food.dart';
import 'package:nowfood/widgets/admin_drawer.dart';
import 'package:nowfood/widgets/features_card.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Admin Home Page'),
      ),
      drawer: AdminDrawer(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: MarginManager.marginL),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           GestureDetector(
             onTap: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) =>const  AdminGetFood()),
               );
             },
             child: const FeatureCard(
               title: 'Get Food',
               description: 'Get food at the cheapest price or pay as much as you wish!',
               imagePath: 'assets/images/get.png',
               backgroundColor: Colors.green,
             ),
           ),
              const SizedBox(
                height: SizeManager.sizeL,
              ),
              GestureDetector(
             onTap: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) =>const AdminSaveFood()),
               );
             },
             child: const FeatureCard(
              title: 'Save Food',
              description: 'Save food for compost fertilizer',
              imagePath: 'assets/images/recycle.png',
              backgroundColor: Colors.green,
             ),
           ),
           /*  FeatureCard(
              title: 'Save Food',
              description: 'Save food for compost fertilizer',
              imagePath: 'assets/images/recycle.png',
              backgroundColor: Colors.green,
            ), */
          ],
        )),
      ),
    ));
  }
}
