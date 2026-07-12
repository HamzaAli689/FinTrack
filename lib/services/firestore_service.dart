import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/transaction_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Current User ID get karne ka secure function
  String get uid {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? 'guest';
  }

  // Transaction Add/Update
  Future<void> addTransactionToFirestore(TransactionModel transaction) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .collection('transactions')
          .doc(transaction.id)
          .set(transaction.toMap());
    } catch (e) {
      throw Exception("Error adding transaction: $e");
    }
  }

  // Delete Transaction
  Future<void> deleteFromFirestore(String id) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .collection('transactions')
          .doc(id)
          .delete();
    } catch (e) {
      throw Exception("Error deleting transaction: $e");
    }
  }

  // Fetch Transactions Stream (Real-time updates)
  Stream<List<TransactionModel>> getTransactionsStream() {
    return _db
        .collection('users')
        .doc(uid)
        .collection('transactions')
    // Optional: Date ke hisaab se order karna (agar model mein date hai)
    // .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => TransactionModel.fromMap(doc.data()))
        .toList());
  }
}