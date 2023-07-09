import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nowfood/model/get_food_model.dart';
import 'package:image_picker/image_picker.dart';

class GetFoodController {
  final CollectionReference _getFoodsCollection =
      FirebaseFirestore.instance.collection('getFoods');
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();

  // Fetch all GetFood items
  Stream<List<GetFood>> getGetFoods() {
    return _getFoodsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => GetFood.fromSnap(doc)).toList();
    });
  }

  // Add a new GetFood item with an image
  Future<void> addGetFood(GetFood getFood, File image, User user) async {
    try {
      // Upload the image to Firebase Storage
      final imageUrl = await _uploadImage(image);

      // Add the GetFood item to Firestore with the current user's ID
      await _getFoodsCollection.add({
        'name': getFood.name,
        'description': getFood.description,
        'phoneNumber': getFood.phoneNumber,
        'address': getFood.address,
        'ownerId': user.uid,
        'imageUrl': imageUrl,
        'price': getFood.price,
      });
    } catch (e) {
      throw Exception('Failed to add GetFood: $e');
    }
  }

  // Update a GetFood item with an image
  Future<void> updateGetFood(GetFood getFood, File? newImage, String name, String description, String phoneNumber, String address, double price) async {
    try {
      // Update the image if a new image is provided
      if (newImage != null) {
        // Delete the existing image from Firebase Storage
        if (getFood.imageUrl.isNotEmpty) {
          final imageRef = _storage.refFromURL(getFood.imageUrl);
          await imageRef.delete();
        }

        // Upload the new image to Firebase Storage
        final newImageUrl = await _uploadImage(newImage);

        // Update the GetFood item in Firestore with the new image URL
        await _getFoodsCollection.doc(getFood.id).update({
          'imageUrl': newImageUrl,
        });
      }

      // Update other fields of the GetFood item in Firestore
      await _getFoodsCollection.doc(getFood.id).update({
        'name': getFood.name,
        'description': getFood.description,
        'phoneNumber': getFood.phoneNumber,
        'address': getFood.address,
        'price': getFood.price,
      });
    } catch (e) {
      throw Exception('Failed to update GetFood: $e');
    }
  }

  // Delete a GetFood item and its corresponding image
  Future<void> deleteGetFood(GetFood getFood) async {
    try {
      // Delete the image from Firebase Storage
      if (getFood.imageUrl.isNotEmpty) {
        final imageRef = _storage.refFromURL(getFood.imageUrl);
        await imageRef.delete();
      }

      // Delete the GetFood item from Firestore
      await _getFoodsCollection.doc(getFood.id).delete();
    } catch (e) {
      throw Exception('Failed to delete GetFood: $e');
    }
  }

  // Upload image to Firebase Storage
  Future<String> _uploadImage(File image) async {
    try {
      final imageName = DateTime.now().millisecondsSinceEpoch.toString();
      final imageRef = _storage.ref().child('getFoods/$imageName.jpg');
      final uploadTask = imageRef.putFile(image);
      final snapshot = await uploadTask.whenComplete(() => null);
      final imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  // Choose an image from gallery
  Future<File?> chooseImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }
}
