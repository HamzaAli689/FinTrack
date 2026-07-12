import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../Dashboard/Dashboard_screen.dart';

class LoginLogic extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login() async {
    try {
      if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        Get.snackbar("Success", "Logged in successfully!");
        Get.offAll(() => DashboardScreen()); // Success ke baad Dashboard par move karein
      } else {
        Get.snackbar("Error", "Please fill all fields");
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Login Error", e.message.toString());
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}