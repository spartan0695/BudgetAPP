import 'dart:collection';

import 'package:flutter/foundation.dart';
import '../models/transactions.dart';
import '../services/database_service.dart';

class BalanceProvider extends ChangeNotifier {
  double _currentBalance = 0.0;
  double _saldoInizialeCache = 0.0;
  double get currentBalance => _currentBalance;
  double get endMonthBalance {
    final oggi=DateTime.now();
    final ultimoGiornoMese=DateTime(oggi.year,oggi.month+1,0);
    return _transactions.where((trx) => !trx.date.isAfter(ultimoGiornoMese))
                                        .fold<double>(0.0,(acc, trx) => 
                                          acc + (trx.isEntry ? trx.amount : -trx.amount))+ _saldoInizialeCache;
  }

  List<Transactions> _transactions = [];
  List<Transactions> get transactions => _transactions;

  /// Aggiorna la lista da db e ricalcola il saldo
  Future<void> loadTransactionsAndBalance() async {
    final items = await DatabaseService().getAllTransactions();
    _transactions = items;

    // Carica il saldo iniziale salvato
    _saldoInizialeCache = await DatabaseService().getSaldoIniziale() ?? 0.0;

    // Calcolo saldo attuale (entrate - uscite fino ad oggi)
    final now = DateTime.now();
    _currentBalance = _saldoInizialeCache + _transactions.where((trx) => !trx.date.isAfter(now))
      .fold(0.0, (acc, trx) => acc + (trx.isEntry ? trx.amount : -trx.amount));
    notifyListeners();
  }

  /// Metodo opzionale per aggiungere una transazione e aggiornare saldo subito
  Future<void> addTransaction(Transactions trx) async {
    await DatabaseService().insertTransaction(trx);
    await loadTransactionsAndBalance();
  }

  Future<void> deleteTransaction(int id) async{
    await DatabaseService().deleteTransaction(id);
    await loadTransactionsAndBalance();
  }

  Future<void> setSaldoIniziale(double saldoIniziale) async {
    // Salva nel database
    await DatabaseService().saveSaldoIniziale(saldoIniziale);
    // Ricarica tutto con il nuovo saldo iniziale
    await loadTransactionsAndBalance();
  }
}

