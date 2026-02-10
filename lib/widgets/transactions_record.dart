import 'package:flutter/material.dart';
import '../styles.dart';
import '../models/transactions.dart';
import 'transaction_detail_popup.dart';

class TransactionsList extends StatelessWidget {
  final List<Transactions> transactions;
  const TransactionsList(this.transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final t = transactions[index];
        return TransRecord(transactions: t);
      },
    );
  }
}

class TransRecord extends StatelessWidget {
  final Transactions transactions;
  const TransRecord({required this.transactions, super.key});

  @override
  Widget build(BuildContext context) {
    final s = appStyles(context);
    
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => TransactionDetailPopup(transaction: transactions),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: s.cardDecoration,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              child: Icon(
                Icons.monetization_on_outlined,
                size: 36,
                color: transactions.isEntry ? Colors.green : Colors.red,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    transactions.name,
                    style: s.transactionTitleStyle,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${transactions.date.day} ${_meseIT(transactions.date.month)}',
                    style: s.transactionDateStyle,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (transactions.isEntry ? '+' : '-') +
                      transactions.amount.toStringAsFixed(2) +
                      ' €',
                  style: s.transactionAmountS.copyWith(
                    color: transactions.isEntry ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  transactions.status,
                  style: s.transactionStatusStyle.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _meseIT(int mese) {
    const mesi = [
      "",
      "Gennaio",
      "Febbraio",
      "Marzo",
      "Aprile",
      "Maggio",
      "Giugno",
      "Luglio",
      "Agosto",
      "Settembre",
      "Ottobre",
      "Novembre",
      "Dicembre"
    ];
    return mesi[mese];
  }
}