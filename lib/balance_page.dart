import 'package:budget_app/balance_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'transaction_page.dart';
import 'styles.dart';
import 'widgets/add_button_menu.dart';
import 'widgets/transactions_record.dart';
import 'widgets/balance_card.dart';
import 'widgets/app_Bar.dart';
import 'widgets/add_entry_popup.dart';
import 'widgets/popup_add.dart';
import 'widgets/footer_menu.dart';
import 'statistics_page.dart';
import 'notificationsSetup_page.dart';
import 'settings_page.dart';
import 'balance_page.dart';

class BalancePage extends StatelessWidget{
    const BalancePage({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(),
            body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BalanceCard(), // 🔥 AGGIUNTA: card bilancio totale
            const SizedBox(height: 16), // 🔥 AGGIUNTA: spazio dopo la card
            AddButtonsMenu(
              onAddEntry: () => showAddEntryPopup(
                context: context,
                titolo: 'Nuova Entrata',
                colorePrimario: Colors.green,
                textButton: 'Aggiungi Spesa',
                isEntry: false,),
              onAddExpense: () => showAddEntryPopup(
                context: context,
                titolo: 'Nuova Spesa',
                colorePrimario: Colors.red,
                textButton: 'Aggiungi Spesa',
                isEntry: true,),
            ),
            const SizedBox(height: 16), // 🔥 AGGIUNTA: spazio dopo la card
            TransRecord(),
            const SizedBox(height: 16), // 🔥 AGGIUNTA: spazio dopo la card
            const SizedBox(height: 8),
          ],
        ),
      ),
      
        );
    }
}