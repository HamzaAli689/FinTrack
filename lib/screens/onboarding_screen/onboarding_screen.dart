import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:todo/screens/sign_up/view.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/widgets/CustomButton.dart';

import '../login/view.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Gap(40),
                Text(
                  'Take Control of \n Your Finances',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Track, Analyze, and Save effortlessly',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 8),
                Container(
                  height: 270,
                  width: 280,
                  child: Image.asset('Assets/images/onboarding2.png'),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 7),
                CustomButton(text: 'Get Started', onPressed: () {
                  Get.to(SignUpPage());
                }),
                Gap(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an Account?',
                      style: TextStyle(color: AppColors.primary1, fontSize: 15),
                    ),
                    Gap(5),
                    InkWell(
                      onTap: () {Get.to(LoginPage());},
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          color: AppColors.primary1,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
