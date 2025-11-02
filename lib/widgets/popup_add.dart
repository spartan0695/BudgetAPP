import 'package:budget_app/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/styles.dart';
import '../skinStyle/styledTextField.dart';
import '../skinStyle/displayField.dart';
import 'popup_tag.dart';
import '../transaction_controller.dart';

void showAddEntryPopup({
  required BuildContext context,
  required String titolo,
  required Color colorePrimario,
  required String textButton,
  required bool isEntry,
}) {
  final trxController = TransactionController();

  
showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SingleChildScrollView(
          child: MovimentoPopup(
            titolo: titolo,
            colorePrimario: colorePrimario,
            textButton: textButton,
            isEntry: isEntry,
            controller: trxController,
          ),
        ),
      );
    },
  );

}


class MovimentoPopup extends StatelessWidget {
  final String titolo;
  final Color colorePrimario;
  final String textButton;
  final bool isEntry;
  final TransactionController controller;

  const MovimentoPopup({
    required this.titolo,
    required this.colorePrimario,
    required this.textButton,
    required this.isEntry,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 4, bottom: 4),
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: const Color.fromARGB(20, 255, 255, 255),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                // es. campo nome
                _buildTextField(controller.nomeController, 'Nome'),
                //DisplayField(label: 'Nome', value: controller.nomeController.text),
                // campo importo e altri campi
                _buildTextField(controller.importoController, 'Importo'),
                // Switch ricorrente con onChanged che modifica controller
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Entrata Ricorrente',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Switch(
                      value: controller.isRicorrente,
                      onChanged: (val) {
                        controller.isRicorrente = val;
                        // qui dovresti chiamare setState se StatefulWidget
                      },
                      activeColor: Colors.green,
                    )
                  ],
                ),
                // Altri campi (periodicità, scadenza, etc.) usando controller
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final trx = controller.buildTransaction(isEntry: isEntry, categoria: 'CategoriaCorrente');
                      print('TRANSACTION DA INSERIRE: ${trx.toMap()}');
                      await controller.addTransaction(trx);
                      print('INSERITO IN DB');
                      Navigator.of(context).pop();
                      
                      // refresh lista dove serve!
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Conferma', style: buttonText),
                  ),
                ),
              ],
            ),
          ),
        ),
        PopupTag(
          text: titolo,
          color: colorePrimario,
          icon: isEntry ? Icons.remove : Icons.add,
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
