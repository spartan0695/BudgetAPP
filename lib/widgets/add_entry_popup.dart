import 'package:budget_app/skinStyle/displayField.dart';
import 'package:budget_app/styles.dart';
import 'package:flutter/material.dart';
import 'popup_tag.dart';
import '../skinStyle/styledTextField.dart';
import '../skinStyle/displayField.dart';
import 'package:budget_app/services/premium_service.dart';
import 'package:budget_app/widgets/paywall_dialog.dart';

void showAddEntryPopupOld(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) =>  SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5), // margine a destra e sinistra
    child: const AddEntryPopup(),
    ),
  );
}

class AddEntryPopup extends StatelessWidget {
  const AddEntryPopup({super.key});

  @override
  Widget build(BuildContext context) {
    // Dati fittizi
    const String nome = 'spesa ';
    const String importo = '€ 2.00';
    const String data = '12 Maggio';
    const bool ricorrente = true;
    const String periodicita = 'Mensile';
    const String scadenza = '12 Maggio 2026';
    const String totale = '1,00€';

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 30, right: 30, top: 4, bottom: 4
          ),
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: const Color.fromARGB(20, 255, 255, 255),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Titolo e chiusura
 /*               Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
*/
                const SizedBox(height: 10),
                //_buildField(label: 'Nome', value: nome),
                DisplayField(label: 'Nome', value: nome),
                _buildField(label: 'Importo', value: importo),
                _buildField(label: 'Data', value: data),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Entrata Ricorrente',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Switch(
                      value: ricorrente,
                      onChanged: (_) {},
                      activeColor: Colors.green,
                    )
                  ],
                ),

                const SizedBox(height: 10),
                _buildField(label: 'Periodicità', value: periodicita),
                _buildField(label: 'Scadenza', value: scadenza),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Totale',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      totale,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Conferma', style: buttonText),
                  ),
                )
              ],
            ),
          ),
        ),

        // Linguetta sopra il popup
        const PopupTag(
          text: 'Nuova Entrata',
          color: Colors.green,
          icon: Icons.add,
        ),
      ],
    );
  }

  Widget _buildField({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 238, 238, 238),
            borderRadius: BorderRadius.circular(12),
          ),
          width: double.infinity,
          child: Text(value),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

// Prima di aggiungere transazione ricorrente
final premiumService = PremiumService();
final currentRecurringCount = await getRecurringTransactionsCount();

if (!premiumService.isPremium && currentRecurringCount >= 3) {
  // Mostra paywall
  showDialog(
    context: context,
    builder: (context) => PaywallDialog(
      featureName: 'Transazioni Ricorrenti Illimitate',
      onUpgrade: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/premium');
      },
    ),
  );
  return;
}

