import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/transactions.dart';

class SyncService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _uid => _auth.currentUser?.uid;

  // Carica una transazione su Firestore
  Future<void> uploadTransaction(Transactions trx) async {
    if (_uid == null) return;

    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('transactions')
        .doc(trx.id?.toString() ?? DateTime.now().millisecondsSinceEpoch.toString())
        .set(trx.toMap());
  }

  // Scarica tutte le transazioni da Firestore
  Future<List<Transactions>> downloadTransactions() async {
    if (_uid == null) return [];

    final snapshot = await _firestore
        .collection('users')
        .doc(_uid)
        .collection('transactions')
        .get();

    return snapshot.docs.map((doc) => Transactions.fromMap(doc.data())).toList();
  }

  // Elimina una transazione da Firestore
  Future<void> deleteTransaction(int id) async {
    if (_uid == null) return;

    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('transactions')
        .doc(id.toString())
        .delete();
  }
}
