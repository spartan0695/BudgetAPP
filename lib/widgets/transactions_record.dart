import 'package:budget_app/skinStyle/transactionStyle.dart';
import 'package:flutter/material.dart';
import '../styles.dart';
import '../models/transactions.dart'; // Il tuo model

class TransactionsList extends StatelessWidget {
  
  final List<Transactions> transactions;
  const TransactionsList(this.transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    // Scrollable vertical list
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // lascia scroll al parent
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final t = transactions[index];
        return TransRecord(
          title: t.name,
          date: t.date,
          amount: t.amount,
          isEntry: t.isEntry,
        );
      },
    );
  }
}

// Aggiorna anche il widget TransRecord per accettare valori veri:
class TransRecord extends StatelessWidget {
  final String title;
  final DateTime date;
  final double amount;
  final bool isEntry;
  const TransRecord({required this.title, required this.date, required this.amount, required this.isEntry, super.key});

  @override
  Widget build(BuildContext context) {
    // Puoi personalizzare la visualizzazione (ad esempio data come stringa, colore su base isEntry, ecc).
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: cardDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.monetization_on_outlined, size: 32, color: isEntry ? Colors.green : Colors.red),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: transactionTitleStyle),
              Text('${date.day}/${date.month}/${date.year}', style: transactionDateStyle),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: entryDecoration,
            child: Text(
              (isEntry ? '+' : '-') + amount.toStringAsFixed(2),
              style: transactionAmountStyle,
            ),
          ),
        ],
      ),
    );
  }
}
