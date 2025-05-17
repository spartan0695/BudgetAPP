import 'package:flutter/material.dart';
import '../styles.dart';

class TransRecord extends StatelessWidget{

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
                      Text('Finanziamento Auto', style: transactionTitle),
                      const SizedBox(height: 0),
                      Text('16 Maggio', style: transactionDate),
                    ],
                  ),
                  //ELEMENTO 3 RIGA
                  const SizedBox(height: 32),
                  Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('324,00 € ', style: transactionAmount),
                      ),
        ],
      ),
    );
    }
}