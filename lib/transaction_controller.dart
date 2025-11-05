import '../models/transactions.dart';
import '../services/database_service.dart';
import 'package:flutter/material.dart';

class TransactionController {
  // Controller dei campi
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController importoController = TextEditingController();
  final TextEditingController dataController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  bool isRicorrente = false;
  String? periodicita; // 'Mensile', 'Settimanale', ecc.
  DateTime? scadenza;
  double get importo =>
      double.tryParse(importoController.text.replaceAll(',', '.')) ?? 0;

  // Funzione per creare il Transaction dal form
  Transactions buildTransaction({
      required bool isEntry, 
      required String categoria,
      required DateTime date,
      required bool isRicorrente,
      String? periodicita,
      DateTime? ricStart,
      DateTime? ricEnd
    }) {
    return Transactions(
      name: nomeController.text,
      amount: importo,
      category: categoria,
      tags: [],
      isEntry: isEntry,
      date: date,
      note: noteController.text,
      isRecurring: isRicorrente,
      recurringFrequency: periodicita,
      recurringStart: DateTime.now(),
      recurringEnd: scadenza,
      // aggiungi altri campi se servono ...
    );
  }

  // Funzione per inserire nel database
  Future<void> addTransaction(Transactions trx) async {
    await DatabaseService().insertTransaction(trx);
  }
}
