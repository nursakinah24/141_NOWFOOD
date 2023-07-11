import 'package:flutter/material.dart';
import 'package:nowfood/controller/get_food_controller.dart';
import 'package:nowfood/manager/values_manager.dart';
import 'package:nowfood/model/get_food_model.dart';
import 'package:nowfood/view/User/Get%20Food/add_get_food.dart';
import 'package:nowfood/view/User/Get%20Food/detail_get_food.dart';

class AdminGetFood extends StatefulWidget {
  const AdminGetFood({Key? key}) : super(key: key);

  @override
  State<AdminGetFood> createState() => _AdminGetFoodState();
}

class _AdminGetFoodState extends State<AdminGetFood> {
  final GetFoodController _getFoodController = GetFoodController();
  List<GetFood> getFoods = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Food'),
      ),
      body: StreamBuilder<List<GetFood>>(
        stream: _getFoodController.getGetFoods(),
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
//Remove the card from the list
    if (getFood.status == 'confirmed') {
      return Container(); // Remove the card from the list
    }
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GetFoodDetail(getFood: getFood),
            ),
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
                height: 200, // Set the desired height for the product image
                width:
                    double.infinity, // Set the width to occupy the entire card
                child: Image.network(
                  getFood.imageUrl,
                  fit: BoxFit
                      .cover, // Adjust the image to cover the entire container
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
                          SizedBox(height: 8),
                          Text(
                            getFood.description,
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 8),
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
                      const SizedBox(
                        width: SizeManager.sizeXXL,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(children: [
                            const Icon(
                              Icons.phone, // Replace with your desired icon
                              color: Colors
                                  .black, // Replace with your desired icon color
                            ),
                            Text(
                              getFood.phoneNumber,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                          SizedBox(height: 8),
                          Row(children: [
                            const Icon(
                              Icons
                                  .location_pin, // Replace with your desired icon
                              color: Colors
                                  .black, // Replace with your desired icon color
                            ),
                            Text(
                              getFood.address,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                          SizedBox(height: 8)
                        ],
                      ),
                    ],
                  )),
              TextButton(
                onPressed: () async {
                  try {
                    await _getFoodController.updateGetFoodStatus(
                        getFood, 'confirmed');
                    setState(() {
                      getFoods.remove(getFood);
                    });
                    print('GetFood status updated successfully!');
                  } catch (e) {
                    print('Failed to update GetFood status: $e');
                  }
                },
                child: const Text('Confirm'),
              ),
            ],
          ),
        ));
  }
}
