import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:todo/utils/app_colors.dart';
import '../../controllers/nav_controller.dart';
import '../../controllers/transaction_controller.dart';
import '../Add_Transection/Add_Transection.dart';
import '../Insights/Insights_screen.dart';
import '../Profile/profile_screen.dart';
import '../transactions/transactions_screen.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final NavController navController = Get.put(NavController());
  final TransactionController controller = Get.put(TransactionController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // SafeArea ko yahan use karein
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Dashboard", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              // Account Balance Card
              _buildBalanceCard(),

              const SizedBox(height: 30),
              const Text("Quick Actions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),

              // Quick Actions Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _quickActionButton(Icons.send, "Send"),
                  _quickActionButton(Icons.qr_code, "Scan"),
                  _quickActionButton(Icons.history, "History"),
                  _quickActionButton(Icons.more_horiz, "More"),
                ],
              ),

              const SizedBox(height: 40),

              // Grid Section - shrinkWrap aur physics ka sahi istemal
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.9, // Grid items ki height maintain karne ke liye
                children: [
                  _menuItem(Icons.send, "Transfer"),
                  _menuItem(Icons.payment, "Bills"),
                  _menuItem(Icons.phone_android, "Mobile"),
                  _menuItem(Icons.account_balance, "Finance"),
                  _menuItem(Icons.shopping_bag, "Market"),
                  _menuItem(Icons.more_horiz, "More"),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary1,
        onPressed: () => Get.to(() => AddTransactionScreen()),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: _buildProfessionalNavBar(),
    );
  }

  // Baki widgets wahi hain, bas layout structure sahi kiya hai
  Widget _buildBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary1.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary1.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Account Balance:", style: TextStyle(fontSize: 16)),
          const Text("\$12,450.00", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text("Monthly Spending: \$2,100.00"),
          const SizedBox(height: 10),
          LinearProgressIndicator(value: 0.4, color: AppColors.primary1),
        ],
      ),
    );
  }

  Widget _quickActionButton(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: AppColors.primary1.withOpacity(0.1),
          child: Icon(icon, color: AppColors.primary1),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _menuItem(IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, spreadRadius: 2)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primary1, size: 28),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildProfessionalNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Obx(() => GNav( // Obx se wrap kiya taake index change ho
            selectedIndex: navController.currentIndex.value, // Highlight current tab
            activeColor: AppColors.primary1,
            color: Colors.grey,
            tabBackgroundColor: AppColors.primary1.withOpacity(0.1),
            padding: const EdgeInsets.all(12),
            gap: 8,
            onTabChange: (index) {
              navController.currentIndex.value = index; // Update index

              // Navigation Logic
              switch (index) {
                case 1: Get.to(() => InsightsScreen()); break;
                case 2: Get.to(() => TransactionsScreen()); break;
                case 3: Get.to(() => ProfileScreen()); break;
                default: break;
              }
            },
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.bar_chart, text: 'Insights'),
              GButton(icon: Icons.history, text: 'History'),
              GButton(icon: Icons.person, text: 'Profile'),
            ],
          )),
        ),
      ),
    );
  }
}