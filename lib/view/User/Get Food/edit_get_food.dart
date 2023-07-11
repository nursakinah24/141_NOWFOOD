import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nowfood/controller/get_food_controller.dart';
import 'package:nowfood/model/get_food_model.dart';

class EditGetFoodPage extends StatefulWidget {
  final GetFood getFood;
  final String existingImage;

  const EditGetFoodPage({
    Key? key,
    required this.getFood,
    required this.existingImage,
  }) : super(key: key);

  @override
  _EditGetFoodPageState createState() => _EditGetFoodPageState();
}

class _EditGetFoodPageState extends State<EditGetFoodPage> {
  final GetFoodController _getFoodController = GetFoodController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  File? _newImage;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.getFood.name;
    _descriptionController.text = widget.getFood.description;
    _phoneNumberController.text = widget.getFood.phoneNumber;
    _addressController.text = widget.getFood.address;
    _priceController.text = widget.getFood.price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Get Food'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildImageSection(),
              const SizedBox(height: 16.0),
              _buildTextField(_nameController, 'Name'),
              const SizedBox(height: 16.0),
              _buildTextField(_descriptionController, 'Description'),
              const SizedBox(height: 16.0),
              _buildTextField(_phoneNumberController, 'Phone Number'),
              const SizedBox(height: 16.0),
              _buildTextField(_addressController, 'Address'),
              const SizedBox(height: 16.0),
              _buildTextField(_priceController, 'Price'),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _updateGetFood,
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return GestureDetector(
      onTap: _chooseImage,
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: _newImage != null
                ? Image.file(
                    _newImage!,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    widget.existingImage,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(height: 8.0),
          TextButton(
            onPressed: _chooseImage,
            child: const Text('Change Image'),
          ),
        ],
      ),
    );
  }

  void _chooseImage() async {
    final pickedImage = await _getFoodController.chooseImage();
    if (pickedImage != null) {
      setState(() {
        _newImage = File(pickedImage.path);
      });
    }
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  void _updateGetFood() async {
    try {
      final name = _nameController.text;
      final description = _descriptionController.text;
      final phoneNumber = _phoneNumberController.text;
      final address = _addressController.text;
      final price = double.parse(_priceController.text);

      await _getFoodController.updateGetFood(
        widget.getFood,
        _newImage,
        name,
        description,
        phoneNumber,
        address,
        price,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('GetFood item updated successfully'),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update Failed'),
            content: const Text('An error occurred during the update.'),
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

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
