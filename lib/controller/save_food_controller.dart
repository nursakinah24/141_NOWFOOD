import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../model/save_food_model.dart';

class SaveFoodController {
  final CollectionReference _saveFoodsCollection =
      FirebaseFirestore.instance.collection('saveFoods');
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();

  // Fetch all GetFood items
  Stream<List<SaveFood>> getSaveFoods() {
    return _saveFoodsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => SaveFood.fromSnap(doc)).toList();
    });
  }

  // Add a new GetFood item with an image
Future<void> addSaveFood(SaveFood saveFood, File image, User user) async {
  try {
    // Get the current user
   // User? currentUser = FirebaseAuth.instance.currentUser;
  //  if (currentUser != null) {
      // Upload the image to Firebase Storage
      final imageUrl = await _uploadImage(image);

      // Add the GetFood item to Firestore with the current user's ID
      await _saveFoodsCollection.add({
        'name': saveFood.name,
        'description': saveFood.description,
        'phoneNumber': saveFood.phoneNumber,
        'address': saveFood.address,
        'ownerId': user.uid, // Set the ownerId field with the current user's ID
        'imageUrl': imageUrl,
        'price': saveFood.price,
      });
  //  } else {
  //    throw Exception('User not authenticated');
 //   }
  } catch (e) {
    throw Exception('Failed to add SaveFood: $e');
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

  // Delete a GetFood item and its corresponding image
  Future<void> deleteSaveFood(SaveFood saveFood) async {
    try {
      // Delete the image from Firebase Storage
      if (saveFood.imageUrl.isNotEmpty) {
        final imageRef = _storage.refFromURL(saveFood.imageUrl);
        await imageRef.delete();
      }

      // Delete the GetFood item from Firestore
      await _saveFoodsCollection.doc(saveFood.id).delete();
    } catch (e) {
      throw Exception('Failed to delete SaveFood: $e');
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
