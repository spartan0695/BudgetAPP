import 'package:flutter/material.dart';
import 'widgets/app_Bar.dart';
import 'widgets/transactions_record.dart';
import 'package:provider/provider.dart';
import 'providers/balance_provider.dart';
import '../models/transactions.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});
  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  bool showRecurringOnly = false;
  String dateFilter = 'tutte';

  List<Transactions> getFilteredList(List<Transactions> all) {
    DateTime now = DateTime.now();
    DateTime in30 = now.add(Duration(days: 30));
    DateTime minus30 = now.subtract(Duration(days: 30));

    List<Transactions> filtered = all;

    // Ricorrenti
    if (showRecurringOnly) {
      filtered = filtered.where((t) => t.isRecurring == 1).toList();
    }
    // Filtro data
    switch (dateFilter) {
      case 'ultimi30':
        filtered = filtered.where((t) => t.date.isAfter(minus30) && t.date.isBefore(now)).toList();
        break;
      case 'prossimi30':
        filtered = filtered.where((t) => t.date.isAfter(now) && t.date.isBefore(in30)).toList();
        break;
      default:
        // tutte
        break;
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BalanceProvider>(
      builder: (context, provider, _) {
        List<Transactions> filteredList = getFilteredList(provider.transactions);
        final transactions = context.watch<BalanceProvider>().transactions;
        return Column(
          
          children: [
            // Riga filtri
            Row(
              
              children: [
                Expanded(
                 child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                margin: EdgeInsets.only(right: 1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 4,
                      offset: Offset(1,2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Text(
                      'Spese Ricorrenti',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black
                      ),
                    ),
                    SizedBox(width: 2),
                    Switch(
                      value: showRecurringOnly,
                      onChanged: (v) => setState(() => showRecurringOnly = v),
                      activeColor: Colors.cyan[700], // come nell'immagine!
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey[300],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 4,
                      offset: Offset(1,2),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dateFilter,
                    icon: Icon(Icons.expand_more, size: 16),
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black
                    ),
                    items: [
                      DropdownMenuItem(value: 'ultimi30', child: Text('Ultimi 30 giorni')),
                      DropdownMenuItem(value: 'prossimi30', child: Text('Prossimi 30 giorni')),
                      DropdownMenuItem(value: 'tutte', child: Text('Tutte')),
                    ],
                    onChanged: (value) => setState(() => dateFilter = value ?? 'tutte'),
                  ),
                ),
              ),
            )
          ],
        ),
            Divider(),
            // Lista delle transazioni filtrate
            Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final t = transactions[index];

                return Dismissible(
                  key: ValueKey(t.id), // Usa id univoco
                  direction: DismissDirection.endToStart, // swipe da destra a sinistra
                  background: Container(
                    color: const Color.fromARGB(255, 237, 102, 93), // sfondo rosso quando swipi
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Conferma cancellazione'),
                        content: const Text('Vuoi cancellare questa transazione?'),
                        actions: [
                          TextButton(
                            child: const Text('No'),
                            onPressed: () => Navigator.of(ctx).pop(false),
                          ),
                          TextButton(
                            child: const Text('Sì'),
                            onPressed: () => Navigator.of(ctx).pop(true),
                          ),
                        ],
                      ),
                    );
                  },
                  onDismissed: (direction) async {
                    // Cancella dal database
                    final provider = Provider.of<BalanceProvider>(context, listen: false);
                    await provider.deleteTransaction(t.id!);
                    await provider.loadTransactionsAndBalance(); // Ricarica tutto dal DB
                  },
                  child: TransRecord(transactions: t,
                    
                  ),
                );
              },
            ),
            ),

          ],
        );
      },
    );
  }
}
