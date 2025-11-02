import 'package:flutter/material.dart';
import '../styles.dart';
import 'package:provider/provider.dart';
import '../providers/balance_provider.dart';

class BalanceCard extends StatelessWidget{

    @override
    Widget build(BuildContext context){
      final balanceProvider = Provider.of<BalanceProvider>(context);
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
              Text('${balanceProvider.currentBalance.toStringAsFixed(2)} €', style: balanceAmountStyle),
              const SizedBox(height: 4),
              ElevatedButton(
                onPressed: () {
                  // Aggiorna (esempi: dopo inserimento, avvio pagina)
                  balanceProvider.loadTransactionsAndBalance();
                },
                child: const Text('Aggiorna saldo'),
              ),
       /*       Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: plusDecoration,
                child: Text('+4,89%', style: percentStyle),
              ),
        */    ],
          ),
          const Icon(Icons.account_balance_wallet_outlined, size: 32),
        ],
      ),
    );
     }
}