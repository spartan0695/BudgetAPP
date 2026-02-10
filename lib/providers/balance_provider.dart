import 'dart:collection';

import 'package:flutter/foundation.dart';
import '../models/transactions.dart';
import '../services/database_service.dart';
import '../services/sync_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  double get endMonth2Balance {
    final oggi=DateTime.now();
    final ultimoGiornoMese=DateTime(oggi.year,oggi.month+2,0);
    return _transactions.where((trx) => !trx.date.isAfter(ultimoGiornoMese))
                                        .fold<double>(0.0,(acc, trx) => 
                                          acc + (trx.isEntry ? trx.amount : -trx.amount))+ _saldoInizialeCache;
  }

  double get endMonth3Balance {
    final oggi=DateTime.now();
    final ultimoGiornoMese=DateTime(oggi.year,oggi.month+3,0);
    return _transactions.where((trx) => !trx.date.isAfter(ultimoGiornoMese))
                                        .fold<double>(0.0,(acc, trx) => 
                                          acc + (trx.isEntry ? trx.amount : -trx.amount))+ _saldoInizialeCache;
  }

  double monthlyIncomesForMonth(int month, int year) {
    return _transactions
        .where((t) => t.isEntry && t.date.month == month && t.date.year == year)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double monthlyOutgoingsForMonth(int month, int year) {
    return _transactions
        .where((t) => !t.isEntry && t.date.month == month && t.date.year == year)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double totalSavingsForMonth(int month, int year) {
    return monthlyIncomesForMonth(month, year) - monthlyOutgoingsForMonth(month, year);
  }

  double get monthlyIncomes {
    DateTime now = DateTime.now();
    return monthlyIncomesForMonth(now.month, now.year);
  }

  double get monthlyOutgoings {
    DateTime now = DateTime.now();
    return monthlyOutgoingsForMonth(now.month, now.year);
  }

  double get totalSavings {
    DateTime now = DateTime.now();
    return totalSavingsForMonth(now.month, now.year);
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
    final id = await DatabaseService().insertTransaction(trx);
    
    // Sincronizza con il cloud se loggato
    if (FirebaseAuth.instance.currentUser != null) {
      final trxWithId = Transactions(
        id: id,
        name: trx.name,
        amount: trx.amount,
        category: trx.category,
        tags: trx.tags,
        isEntry: trx.isEntry,
        date: trx.date,
        note: trx.note,
        isRecurring: trx.isRecurring,
        recurringFrequency: trx.recurringFrequency,
        recurringStart: trx.recurringStart,
        recurringEnd: trx.recurringEnd,
        recurringCount: trx.recurringCount,
      );
      await SyncService().uploadTransaction(trxWithId);
    }
    
    await loadTransactionsAndBalance();
  }

  Future<void> updateTransaction(Transactions trx) async {
    await DatabaseService().updateTransaction(trx);

    // Sincronizza con il cloud se loggato
    if (FirebaseAuth.instance.currentUser != null) {
      await SyncService().uploadTransaction(trx);
    }

    await loadTransactionsAndBalance();
  }

  Future<void> deleteTransaction(int id) async{
    await DatabaseService().deleteTransaction(id);
    
    // Elimina dal cloud se loggato
    if (FirebaseAuth.instance.currentUser != null) {
      await SyncService().deleteTransaction(id);
    }
    
    await loadTransactionsAndBalance();
  }

  /// Scarica i dati dal cloud e sovrascrive/integra quelli locali
  Future<void> syncFromCloud() async {
    if (FirebaseAuth.instance.currentUser == null) return;

    final cloudTransactions = await SyncService().downloadTransactions();
    
    for (var trx in cloudTransactions) {
      // Per semplicità, inseriamo tutto nel DB locale (sqflite gestirà i duplicati se l'ID è lo stesso)
      // Nota: in una app reale faremmo un controllo più granulare
      await DatabaseService().insertTransaction(trx);
    }
    
    await loadTransactionsAndBalance();
  }

  Future<void> setSaldoIniziale(double saldoIniziale) async {
    // Salva nel database
    await DatabaseService().saveSaldoIniziale(saldoIniziale);
    // Ricarica tutto con il nuovo saldo iniziale
    await loadTransactionsAndBalance();
  }

  Future<void> addTransactionRicorrente(
  Transactions trx,
  String recurringFrequency, // 'weekly', 'monthly', 'bimonthly', 'yearly'
  DateTime recurringStart,
  DateTime recurringEnd,
) async {
  
  DateTime currentDate = recurringStart;

  // Cicla finché la data corrente è precedente o uguale alla data di fine
  while (currentDate.isBefore(recurringEnd) || currentDate.isAtSameMomentAs(recurringEnd)) {
    
    // Crea la transazione per la data corrente
    Transactions newTrx = Transactions(
      name: trx.name,
      amount: trx.amount,
      category: trx.category,
      tags: trx.tags,
      isEntry: trx.isEntry,
      date: currentDate, // Usa la data calcolata
      note: trx.note,
      isRecurring: true,
      recurringFrequency: recurringFrequency,
      recurringStart: recurringStart,
      recurringEnd: recurringEnd,
    );

    final id = await DatabaseService().insertTransaction(newTrx);

    // Sincronizza ogni istanza ricorrente con il cloud
    if (FirebaseAuth.instance.currentUser != null) {
      final trxWithId = newTrx.copyWith(id: id);
      await SyncService().uploadTransaction(trxWithId);
    }

    // Calcola la PROSSIMA data in base alla frequenza
    switch (recurringFrequency.toLowerCase()) {
      case 'weekly':
      case 'settimanale':
        currentDate = currentDate.add(const Duration(days: 7));
        break;
        
      case 'monthly':
      case 'mensile':
        // Incrementa esattamente di 1 mese mantenendo il giorno
        // Esempio: 1 Gennaio -> 1 Febbraio -> 1 Marzo
        currentDate = DateTime(currentDate.year, currentDate.month + 1, currentDate.day);
        break;
        
      case 'bimonthly':
      case 'bimestrale':
        // Incrementa esattamente di 2 mesi
        currentDate = DateTime(currentDate.year, currentDate.month + 2, currentDate.day);
        break;
        
      case 'yearly':
      case 'annuale':
        // Incrementa esattamente di 1 anno
        currentDate = DateTime(currentDate.year + 1, currentDate.month, currentDate.day);
        break;
        
      default:
        // Default mensile se non riconosciuto
        currentDate = DateTime(currentDate.year, currentDate.month + 1, currentDate.day);
    }
  }

  await loadTransactionsAndBalance();
  notifyListeners();
}

}

