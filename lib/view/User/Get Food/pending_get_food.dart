import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nowfood/controller/get_food_controller.dart';
import 'package:nowfood/manager/values_manager.dart';
import 'package:nowfood/model/get_food_model.dart';
import 'package:nowfood/view/User/Get%20Food/detail_get_food.dart';
import 'package:nowfood/view/User/Get%20Food/edit_get_food.dart';

class PendingGetFoodPage extends StatefulWidget {
  const PendingGetFoodPage({Key? key}) : super(key: key);

  @override
  State<PendingGetFoodPage> createState() => _PendingGetFoodPageState();
}

class _PendingGetFoodPageState extends State<PendingGetFoodPage> {
  final GetFoodController _getFoodController = GetFoodController();

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Get Food'),
      ),
    body: StreamBuilder<List<GetFood>>(
        stream: currentUser != null
            ? _getFoodController.getPendingGetFoods(currentUser)
            : Stream<List<GetFood>>.empty(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final getFoods = snapshot.data!;
            return ListView(
              children: getFoods
                  .map((getFood) => _buildGetFoodCard(getFood))
                  .toList(),
            );
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

Widget _buildGetFoodCard(GetFood getFood) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GetFoodDetail(getFood: getFood),
        ),
      );
    },
    onLongPress: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Manage Get Food'),
            content: Text('What would you like to do?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _updateGetFood(getFood);
                },
                child: Row(
                  children: const [
                    Icon(Icons.edit),
                    SizedBox(width: 4),
                    Text('Update'),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _deleteGetFood(getFood);
                },
                child: Row(
                  children: const [
                    Icon(Icons.delete),
                    SizedBox(width: 4),
                    Text('Delete'),
                  ],
                ),
              ),
            ],
          );
        },
      );
    },
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: Image.network(
              getFood.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getFood.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      getFood.description,
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\Rp${getFood.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: SizeManager.sizeXXL),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                        Text(
                          getFood.phoneNumber,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_pin,
                          color: Colors.black,
                        ),
                        Text(
                          getFood.address,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.pending_actions,
                          color: Colors.black,
                        ),
                        Text(
                          'On Review',
                          style: const TextStyle(
                            color: Colors.yellow,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

void _updateGetFood(GetFood getFood) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditGetFoodPage(getFood: getFood, existingImage: getFood.imageUrl,),
    ),
  );
}

void _deleteGetFood(GetFood getFood) async {
  try {
    await _getFoodController.deleteGetFood(getFood);
  } catch (e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Failed'),
          content: const Text('An error occurred during the delete.'),
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
