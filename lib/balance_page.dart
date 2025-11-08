import 'package:budget_app/balance_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'transaction_page.dart';
import 'styles.dart';
import 'widgets/add_button_menu.dart';
import 'widgets/transactions_record.dart';
import 'widgets/balance_card.dart';
import 'widgets/app_Bar.dart';
import 'widgets/NOTUSEDadd_entry_popup.dart';
import 'widgets/popup_add.dart';
import 'widgets/footer_menu.dart';
import 'statistics_page.dart';
import 'notificationsSetup_page.dart';
import 'settings_page.dart';
import 'balance_page.dart';
import 'widgets/paywall_dialog.dart';
import 'widgets/premium_badge.dart';
import 'services/premium_service.dart';
import 'package:provider/provider.dart';
import 'providers/balance_provider.dart';

class BalancePage extends StatelessWidget{
    const BalancePage({super.key});
    
    

    @override
    Widget build(BuildContext context) {
      final isPremium = PremiumService().isPremium;
      
      final transactions = context.watch<BalanceProvider>().transactions;
        return Scaffold(
            appBar: AppBar(),
            body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BalanceCard(), // 🔥 AGGIUNTA: card bilancio totale
            const SizedBox(height: 16), // 🔥 AGGIUNTA: spazio dopo la card
            AddButtonsMenu(
              onAddEntry: () => showAddEntryPopup(
                context: context,
                titolo: 'Nuova Entrata',
                colorePrimario: Colors.green,
                textButton: 'Aggiungi Entrata',
                isEntry: true,),
              onAddExpense: () => showAddEntryPopup(
                context: context,
                titolo: 'Nuova Uscita',
                colorePrimario: Colors.red,
                textButton: 'Aggiungi Uscita',
                isEntry: false,),
            ),
            const SizedBox(height: 16), // 🔥 AGGIUNTA: spazio dopo la card

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



            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
      children:[
              PremiumBadge(
                  isPremium: isPremium,
                onFeatureTap: () => Navigator.pushNamed(context, '/advanced'),
                onUpgradeRequested: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => PaywallDialog(
                      onShowPremiumPage: () {
                        Navigator.pushNamed(context, '/premium');
                      },
                    ),
                  );
                },
                child: ElevatedButton(
                  onPressed: null,
                  child: const Text('Funzionalità avanzata'),
                ),
              )
              ],),
            const SizedBox(height: 16), // 🔥 AGGIUNTA: spazio dopo la card
          ],
        ),
      ),
      
        );
    }
}