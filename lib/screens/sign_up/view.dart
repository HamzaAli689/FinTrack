import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:todo/screens/login/view.dart';

import '../../utils/app_colors.dart';
import '../../widgets/CustomButton.dart';
import '../../widgets/custom_textfeild.dart';
import 'logic.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  // Controller ko yahan initialize kiya
  final SignUpLogic logic = Get.put(SignUpLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(40),
              const Text(
                'Create Account',
                style: TextStyle(color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Sign up to start tracking',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const Gap(100),

              // Yahan controllers ko assign kiya
              CustomTextField(
                hint: 'Full Name',
                icon: Icons.person_outline,
                controller: logic.nameController, // Assign kiya
              ),
              const Gap(16),
              CustomTextField(
                hint: 'Email',
                icon: Icons.email_outlined,
                controller: logic.emailController, // Assign kiya
              ),
              const Gap(16),
              CustomTextField(
                hint: 'Password',
                icon: Icons.lock_outline,
                isPassword: true,
                controller: logic.passwordController, // Assign kiya
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height /4.0,
              ),

              Center(
                child: CustomButton(
                    text: 'Sign Up',
                    onPressed: () {
                      // Logic function call kiya
                      logic.signUp();
                    }
                ),
              ),

              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? ', style: TextStyle(color: Colors.black54)),
                  InkWell(
                    onTap: () => Get.to(() => LoginPage()),
                    child: Text(
                      'Login',
                      style: TextStyle(color: AppColors.primary1, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}