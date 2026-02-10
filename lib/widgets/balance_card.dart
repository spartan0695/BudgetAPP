import 'package:flutter/material.dart';
import '../styles.dart';
import 'package:provider/provider.dart';
import '../providers/balance_provider.dart';

class BalanceCard extends StatelessWidget{
  const BalanceCard({super.key});


    @override
    Widget build(BuildContext context){
      final balanceProvider = Provider.of<BalanceProvider>(context);
      final s = appStyles(context);
      
      return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.all(16),
      decoration: s.cardDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bilancio Totale', style: s.balanceTitleStyle),
              const SizedBox(height: 2),
              Text('${balanceProvider.currentBalance.toStringAsFixed(2)} €', style: s.balanceAmountStyle),
              const SizedBox(height: 2),
              Text('Proiezione a fine mese', style: s.balanceTitleStyle),
              const SizedBox(height: 2),
              Text('${balanceProvider.endMonthBalance.toStringAsFixed(2)} €', style: s.endBalanceAmountStyle),
              const SizedBox(height: 2),
              ElevatedButton(
                onPressed: () {
                  balanceProvider.loadTransactionsAndBalance();
                },
                child: const Text('Aggiorna saldo'),
              ),
            ],
          ),
          const Icon(Icons.account_balance_wallet_outlined, size: 32),
        ],
      ),
    );
     }
}