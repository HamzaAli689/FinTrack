import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/utils/app_colors.dart';
import '../../controllers/transaction_controller.dart';
import '../../models/transaction_model.dart';

class TransactionsScreen extends StatelessWidget {
  final TransactionController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Transactions History",style: TextStyle(color: Colors.white),),backgroundColor: AppColors.primary1,),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: controller.transactionList.length,
        itemBuilder: (context, index) {
          var item = controller.transactionList[index];
          return _transactionItem(item);
        },
      )),
    );
  }

  Widget _transactionItem(TransactionModel item) {
    // Icon logic...
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(Icons.attach_money),
        title: Text("${item.category}: ${item.note}"),
        trailing: Text("\$${item.amount.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}