import 'package:budget_app/skinStyle/transactionStyle.dart';
import 'package:flutter/material.dart';
import '../styles.dart';

class TransRecord extends StatelessWidget{

  final String transactionTitle = ('Finanziamento');
  final String transactionDate = ('16 maggio');
  final String transactionAmount = ('324');

    @override
    Widget build(BuildContext context){
      return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.all(16),
      decoration: cardDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
                  //ELEMENTO 1 RIGA
                  const Icon(Icons.monetization_on_outlined, size: 32),
                  //ELEMENTO 2 RIGA
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(transactionTitle, style: transactionTitleStyle),
                      const SizedBox(height: 0),
                      Text(transactionDate, style: transactionDateStyle),
                    ],
                  ),
                  //ELEMENTO 3 RIGA
                  const SizedBox(height: 32),
                  Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: entryDecoration,
                        child: Text(transactionAmount, style: transactionAmountStyle),
                      ),
        ],
      ),
    );
    }
}