import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nowfood/controller/get_food_controller.dart';
import 'package:nowfood/manager/values_manager.dart';
import 'package:nowfood/model/get_food_model.dart';
import 'package:nowfood/view/User/Get%20Food/get_food_page.dart';
import 'package:nowfood/view/login_page.dart';

class AddGetFood extends StatefulWidget {
  const AddGetFood({Key? key}) : super(key: key);

  @override
  _AddGetFoodState createState() => _AddGetFoodState();
}

class _AddGetFoodState extends State<AddGetFood> {
  final GetFoodController _getFoodController = GetFoodController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  File? _selectedImage;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String getCurrentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Add GetFood'),
            ),
            body: Center(
                child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(
                    vertical: MarginManager.marginXL,
                    horizontal: MarginManager.marginXL),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (_selectedImage != null) Image.file(_selectedImage!),
                      ElevatedButton(
                        child: const Text('Choose Image'),
                        onPressed: () async {
                          _selectedImage =
                              await _getFoodController.chooseImage();
                          setState(() {});
                        },
                      ),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _phoneNumberController,
                        decoration:
                            const InputDecoration(labelText: 'Phone Number'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(labelText: 'Address'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an address';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _priceController,
                        decoration: const InputDecoration(labelText: 'Price'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a price';
                          }
                          final price = int.tryParse(value);
                          if (price == null || price <= 0) {
                            return 'Please enter a valid price';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: SizeManager.sizeM,
                      ),
                      ElevatedButton(
                        child: const Text('Add'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                              final getFood = GetFood(
                                id: '',
                                name: _nameController.text,
                                description: _descriptionController.text,
                                phoneNumber: _phoneNumberController.text,
                                address: _addressController.text,
                                ownerId: getCurrentUserId(),
                                imageUrl: '',
                                price: int.parse(_priceController.text),
                              );
                              final user = FirebaseAuth.instance.currentUser;
                                if (user != null) {
                               _getFoodController.addGetFood(
                                  getFood, _selectedImage!, user);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const GetFoodPage()),
                              );
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ))));
  }
}
