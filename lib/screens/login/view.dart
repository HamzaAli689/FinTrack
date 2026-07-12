import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/widgets/CustomButton.dart';
import '../../widgets/custom_textfeild.dart';
import '../sign_up/view.dart';
import 'logic.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginLogic logic = Get.put(LoginLogic());

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
                'Welcome Back',
                style: TextStyle(color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Log in to continue',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const Gap(100),

              // Controllers link kar diye
              CustomTextField(
                hint: 'Email',
                icon: Icons.email_outlined,
                controller: logic.emailController, // Controller linked
              ),
              const Gap(16),
              CustomTextField(
                hint: 'Password',
                icon: Icons.lock_outline,
                isPassword: true,
                controller: logic.passwordController, // Controller linked
              ),

              const Gap(10),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text('Forgot Password?', style: TextStyle(color: AppColors.primary1)),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height /3.7,
              ),


              Center(
                child: CustomButton(
                  text: 'Log In',
                  onPressed: () => logic.login(), // Logic call kar di
                ),
              ),

              const Gap(20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account? ', style: TextStyle(color: Colors.black54)),
                  InkWell(
                    onTap: () => Get.to(() => SignUpPage()),
                    child: Text(
                      'Sign Up',
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