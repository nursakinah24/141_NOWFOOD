import 'package:flutter/material.dart';
import 'package:nowfood/manager/values_manager.dart';
import 'package:nowfood/view/User/Get%20Food/history_get_food.dart';
import 'package:nowfood/view/User/Save%20Food/history_save_food.dart';
import 'package:nowfood/widgets/user_drawer.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('History'),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: MarginManager.marginL),
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: SizeManager.sizeL),
            children: [
              ListTile(
                leading: Icon(
                  Icons.food_bank,
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
                subtitle: Text('Your get food history'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryGetFoodPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.save,
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
                subtitle: Text('Your save food history'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistorySaveFoodPage()),
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
