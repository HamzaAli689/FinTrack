import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:todo/widgets/CustomButton.dart';
import '../../controllers/transaction_controller.dart';
import '../../models/transaction_model.dart';
import '../../widgets/custom_textfeild.dart';

class AddTransactionScreen extends StatelessWidget {
  AddTransactionScreen({super.key});

  final TransactionController controller = Get.find();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  // Category List
  final List<String> categories = ["Groceries", "Fuel", "Entertainment", "Education", "Fees"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Add Transaction"), elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomTextField(hint: '\$0.00', icon: Icons.attach_money, controller: amountController),
              const Gap(30),

              // Dynamic Category Selector using ChoiceChips
              const Align(alignment: Alignment.centerLeft, child: Text("Select Category", style: TextStyle(fontWeight: FontWeight.bold))),
              const Gap(10),
              Obx(() => Wrap(
                spacing: 10,
                children: categories.map((cat) {
                  return ChoiceChip(
                    label: Text(cat),
                    selected: controller.selectedCategory.value == cat,
                    onSelected: (selected) {
                      if (selected) controller.selectedCategory.value = cat;
                    },
                  );
                }).toList(),
              )),
              const Gap(30),

              CustomTextField(hint: 'Notes (e.g., Book Fee)', icon: Icons.edit, controller: noteController),
              const Gap(40),

              CustomButton(
                text: 'Save',
                onPressed: () {
                  if (amountController.text.isNotEmpty) {
                    final newTransaction = TransactionModel(
                      id: DateTime.now().toString(),
                      amount: double.tryParse(amountController.text) ?? 0.0,
                      category: controller.selectedCategory.value, // Dynamic Category
                      date: DateTime.now(),
                      note: noteController.text, // User ka likha hua Note
                    );

                    controller.addTransaction(newTransaction);
                    Get.back();
                  } else {
                    Get.snackbar("Error", "Please enter an amount");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}