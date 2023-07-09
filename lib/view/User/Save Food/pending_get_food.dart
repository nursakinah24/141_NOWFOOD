import 'package:flutter/material.dart';
import 'package:nowfood/controller/get_food_controller.dart';
import 'package:nowfood/controller/save_food_controller.dart';
import 'package:nowfood/manager/values_manager.dart';
import 'package:nowfood/model/get_food_model.dart';
import 'package:nowfood/model/save_food_model.dart';
import 'package:nowfood/view/User/Get%20Food/add_get_food.dart';
import 'package:nowfood/view/User/Get%20Food/detail_get_food.dart';

class PendingSaveFoodPage extends StatefulWidget {
  const PendingSaveFoodPage({Key? key}) : super(key: key);

  @override
  State<PendingSaveFoodPage> createState() => _PendingSaveFoodPageState();
}

class _PendingSaveFoodPageState extends State<PendingSaveFoodPage> {
  final SaveFoodController _saveFoodController = SaveFoodController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Save Food'),
      ),
      body: StreamBuilder<List<SaveFood>>(
        stream: _saveFoodController.getSaveFoods(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final saveFoods = snapshot.data!;
            return ListView(
              children: saveFoods
                  .map((saveFood) => _buildSaveFoodCard(saveFood))
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

  Widget _buildSaveFoodCard(SaveFood saveFood) {
    /*  final priceFormat = NumberFormat.currency(
    symbol: 'Rp',
    decimalDigits: 2,
    locale: 'id_ID',
  );
  final formattedPrice = priceFormat.format(getFood.price); */
    return GestureDetector(
        /* onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SaveFoodDetail(getFood: getFood),
            ),
          ); */
       // },
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
                  saveFood.imageUrl,
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
                            saveFood.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            saveFood.description,
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '\Rp${saveFood.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: SizeManager.sizeXXL,),
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
                              saveFood.phoneNumber,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                          SizedBox(height: 8),
                          Row(children: [
                            const Icon(
                              Icons.location_pin, // Replace with your desired icon
                              color: Colors
                                  .black, // Replace with your desired icon color
                            ),
                            Text(
                              saveFood.address,
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
                  ))
            ],
          ),
        ));
  }
}
