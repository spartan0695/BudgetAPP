import 'package:flutter/material.dart';
import 'widgets/app_Bar.dart';
import 'widgets/transactions_record.dart';
import 'package:provider/provider.dart';
import 'providers/balance_provider.dart';
import '../models/transactions.dart';
import 'styles.dart';

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
    final s = appStyles(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Consumer<BalanceProvider>(
      builder: (context, provider, _) {
        List<Transactions> filteredList = getFilteredList(provider.transactions);
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Riga filtri
              Row(
                children: [
                  Expanded(
                    flex: 6, // Diamo un po' più di spazio alla parte sinistra
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: s.cardDecoration,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'Ricorrenti',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13, 
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Switch(
                            value: showRecurringOnly,
                            onChanged: (v) => setState(() => showRecurringOnly = v),
                            activeColor: s.containerColor,
                            inactiveThumbColor: isDark ? Colors.grey[400] : Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: s.cardDecoration,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dateFilter,
                          icon: const Icon(Icons.expand_more, size: 16),
                          style: TextStyle(
                             fontSize: 13, 
                             fontWeight: FontWeight.w400, 
                             color: isDark ? Colors.white : Colors.black,
                          ),
                          dropdownColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                          items: const [
                            DropdownMenuItem(value: 'ultimi30', child: Text('Scorsi')),
                            DropdownMenuItem(value: 'prossimi30', child: Text('Futuri')),
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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final t = filteredList[index];
                  return Dismissible(
                    key: ValueKey(t.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: const Color.fromARGB(255, 237, 102, 93),
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
                      final provider = Provider.of<BalanceProvider>(context, listen: false);
                      await provider.deleteTransaction(t.id!);
                      await provider.loadTransactionsAndBalance();
                    },
                    child: TransRecord(transactions: t),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
