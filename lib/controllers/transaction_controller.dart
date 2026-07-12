import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/transaction_model.dart';
import '../services/firestore_service.dart';

class TransactionController extends GetxController {
  var selectedCategory = 'Groceries'.obs;
  final box = Hive.box<TransactionModel>('transactions');
  var transactionList = <TransactionModel>[].obs;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void onInit() {
    super.onInit();
    // User login hone par data load karein
    loadUserTransactions();
  }

  void loadUserTransactions() {
    // _firestoreService.getTransactionsStream() ab seedha List<TransactionModel> return kar raha hai
    _firestoreService.getTransactionsStream().listen((List<TransactionModel> transactions) {
      // Yahan .docs ki zaroorat nahi hai, kyunki 'transactions' khud list hai
      transactionList.value = transactions;
    });
  }

  void addTransaction(TransactionModel transaction) {
    // 1. Local save
    box.add(transaction);

    // 2. Local list update
    transactionList.add(transaction);

    // 3. Firestore save (ye service ab uid handle kar rahi hai)
    _firestoreService.addTransactionToFirestore(transaction);
  }

  void deleteTransaction(TransactionModel transaction) {
    // 1. Firebase se delete
    _firestoreService.deleteFromFirestore(transaction.id);

    // 2. Local list se remove
    transactionList.remove(transaction);

    // 3. Local Hive se delete
    transaction.delete();
  }
}