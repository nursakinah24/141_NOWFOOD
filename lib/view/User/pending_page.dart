import 'package:flutter/material.dart';
import 'package:nowfood/manager/values_manager.dart';
import 'package:nowfood/view/User/Get%20Food/pending_get_food.dart';
import 'package:nowfood/view/User/Save%20Food/pending_get_food.dart';
import 'package:nowfood/widgets/user_drawer.dart';

class PendingPage extends StatelessWidget {
  const PendingPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Pending'),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: MarginManager.marginL),
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: SizeManager.sizeL),
            children: [
              ListTile(
                leading: Icon(
                  Icons.pending_outlined,
                  color: Colors.green,
                  size: 48,
                ),
                title: Text(
                  'Get Food',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('See your pending item here.'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PendingGetFoodPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.food_bank,
                  color: Colors.green,
                  size: 48,
                ),
                title: Text(
                  'Save Food',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('See your pending item here.'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PendingSaveFoodPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
