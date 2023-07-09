import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nowfood/controller/get_food_controller.dart';
import 'package:nowfood/model/get_food_model.dart';
import 'package:image_picker/image_picker.dart';

class EditGetFoodPage extends StatefulWidget {
  final GetFood getFood;

  const EditGetFoodPage({Key? key, required this.getFood}) : super(key: key);

  @override
  _EditGetFoodPageState createState() => _EditGetFoodPageState();
}

class _EditGetFoodPageState extends State<EditGetFoodPage> {
  final GetFoodController _getFoodController = GetFoodController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _addressController;
  late TextEditingController _priceController;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.getFood.name);
    _descriptionController = TextEditingController(text: widget.getFood.description);
    _phoneNumberController = TextEditingController(text: widget.getFood.phoneNumber);
    _addressController = TextEditingController(text: widget.getFood.address);
    _priceController = TextEditingController(text: widget.getFood.price.toString());
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Get Food'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (_imageFile != null)
                Image.file(
                  _imageFile!,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Select Image'),
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value!.isEmpty) {
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
                  if (value!.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _updateGetFood,
                child: const Text('Update Get Food'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickImage() async {
    final pickedImage = await _getFoodController.chooseImage();
    setState(() {
      _imageFile = pickedImage;
    });
  }

  void _updateGetFood() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final description = _descriptionController.text;
      final phoneNumber = _phoneNumberController.text;
      final address = _addressController.text;
      final price = double.parse(_priceController.text);

      try {
        await _getFoodController.updateGetFood(
          widget.getFood,
          _imageFile,
          name,
          description,
          phoneNumber,
          address,
          price,
        );
        Navigator.pop(context);
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
  }
}
