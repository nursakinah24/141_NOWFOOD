import 'package:flutter/material.dart';
import 'package:nowfood/manager/values_manager.dart';
import 'package:nowfood/view/User/Get%20Food/get_food_page.dart';
import 'package:nowfood/view/User/Save%20Food/save_food_page.dart';
import 'package:nowfood/view/User/pending_page.dart';
import 'package:nowfood/widgets/features_card.dart';
import 'package:nowfood/widgets/user_drawer.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: UserDrawer(),
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
                 MaterialPageRoute(builder: (context) =>const  GetFoodPage()),
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
                 MaterialPageRoute(builder: (context) =>const  SaveFoodPage()),
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
