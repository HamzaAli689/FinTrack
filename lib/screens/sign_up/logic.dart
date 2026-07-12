import 'package:cloud_firestore/cloud_firestore.dart'; // Import this
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Dashboard/Dashboard_screen.dart';

class SignUpLogic extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance; // Add Firestore instance

  Future<void> signUp() async {
    try {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          nameController.text.isNotEmpty) { // Name check zaroor karein

        // 1. Auth create karein
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        // 2. Firestore mein data save karein (YAHI MISSING THA)
        await _db.collection('users').doc(userCredential.user!.uid).set({
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'uid': userCredential.user!.uid,
          'createdAt': DateTime.now(),
        });

        Get.offAll(() =>  DashboardScreen());
        Get.snackbar("Success", "Account created successfully!");
      } else {
        Get.snackbar("Error", "Please fill all fields");
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Auth Error", e.message.toString());
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
// ... onClose code ...
}