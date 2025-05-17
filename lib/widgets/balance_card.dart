import 'package:flutter/material.dart';
import '../styles.dart';

class BalanceCard extends StatelessWidget{

    @override
    Widget build(BuildContext context){
      return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.all(16),
      decoration: cardDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bilancio Totale', style: balanceTitleStyle),
              const SizedBox(height: 4),
              Text('\$149.868', style: balanceAmountStyle),
              const SizedBox(height: 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('+4,89%', style: percentStyle),
              ),
            ],
          ),
          const Icon(Icons.account_balance_wallet_outlined, size: 32),
        ],
      ),
    );
     }
}