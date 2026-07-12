import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/ProfileController.dart';
import '../../controllers/nav_controller.dart';
import 'package:todo/utils/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override

  Widget build(BuildContext context) {
    print("Building Profile Screen...");
    // Controller initialize karein
    final ProfileController profileController = Get.put(ProfileController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<NavController>().currentIndex.value = 3;
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
        elevation: 0,
        backgroundColor: AppColors.primary1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  "https://ui-avatars.com/api/?name=${profileController.name.value}&background=random&size=200"
              ),
            ),
            const SizedBox(height: 15),

            // DYNAMIC NAME
            Obx(() => Text(profileController.name.value,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),

            // DYNAMIC EMAIL
            Obx(() => Text(profileController.email.value,
                style: const TextStyle(color: Colors.grey))),

            const SizedBox(height: 30),

            _buildProfileItem(Icons.edit, "Edit Profile"),
            _buildProfileItem(Icons.security, "Privacy & Security"),
            _buildProfileItem(Icons.notifications, "Notifications"),
            _buildProfileItem(Icons.help_outline, "Help & Support"),
            const Divider(),
            _buildProfileItem(Icons.logout, "Logout", isLogout: true),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title, {bool isLogout = false}) {
    return InkWell( // Clickable banane ke liye
      onTap: () {
        if(isLogout) {
          // Yahan Logout logic daalein (FirebaseAuth.instance.signOut())
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(icon, color: isLogout ? Colors.red : AppColors.primary1),
            const SizedBox(width: 15),
            Text(title, style: TextStyle(
                fontSize: 16,
                color: isLogout ? Colors.red : Colors.black87,
                fontWeight: FontWeight.w600
            )),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}