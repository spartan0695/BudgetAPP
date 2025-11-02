import 'package:flutter/foundation.dart';
import '../models/transactions.dart';
import '../services/database_service.dart';

class BalanceProvider extends ChangeNotifier {
  double _currentBalance = 0.0;
  double get currentBalance => _currentBalance;

  List<Transactions> _transactions = [];
  List<Transactions> get transactions => _transactions;

  /// Aggiorna la lista da db e ricalcola il saldo
  Future<void> loadTransactionsAndBalance() async {
    final items = await DatabaseService().getAllTransactions();
    _transactions = items;

    // Calcolo saldo attuale (entrate - uscite fino ad oggi)
    final now = DateTime.now();
    _currentBalance = _transactions.where((trx) => !trx.date.isAfter(now))
      .fold(0.0, (acc, trx) => acc + (trx.isEntry ? trx.amount : -trx.amount));

    notifyListeners();
  }

  /// Metodo opzionale per aggiungere una transazione e aggiornare saldo subito
  Future<void> addTransaction(Transactions trx) async {
    await DatabaseService().insertTransaction(trx);
    await loadTransactionsAndBalance();
  }
}
