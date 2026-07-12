import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ProfileController extends GetxController {
  var name = "Loading...".obs;
  var email = "Loading...".obs;

  @override
  void onInit() {
    super.onInit();
    print("Controller Initialized!"); // Terminal mein ye print check karein
    fetchUserData();
  }

  void fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          // Data mil gaya
          name.value = userDoc.get('name') ?? "No Name";
          email.value = userDoc.get('email') ?? "No Email";
        } else {
          name.value = "User not found";
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
      name.value = "Error loading";
    }
  }
}