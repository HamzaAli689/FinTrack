import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import this
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:todo/screens/onboarding_screen/onboarding_screen.dart';
import 'package:todo/screens/splash/splash_screen.dart';

import 'models/transaction_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase init

  await Hive.initFlutter(); // Hive init
  Hive.registerAdapter(TransactionModelAdapter()); // Jo file abhi generate hui hai
  await Hive.openBox<TransactionModel>('transactions'); // Box open

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}