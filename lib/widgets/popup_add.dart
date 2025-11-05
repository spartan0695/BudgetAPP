import 'package:flutter/material.dart';
import '../transaction_controller.dart';
import '../widgets/date_picker.dart'; // importa il tuo nuovo widget
import '../styles.dart';

class MovimentoPopup extends StatefulWidget {
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
    Key? key,
  }) : super(key: key);

  @override
  State<MovimentoPopup> createState() => _MovimentoPopupState();
}

void showAddEntryPopup({
  required BuildContext context,
  required String titolo,
  required Color colorePrimario,
  required String textButton,
  required bool isEntry,
}) {
  final trxController = TransactionController();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // fondamentale!
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) {
      final bottomInset = MediaQuery.of(sheetContext).viewInsets.bottom;
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: SingleChildScrollView(
            child: MovimentoPopup(
              titolo: titolo,
              colorePrimario: colorePrimario,
              textButton: textButton,
              isEntry: isEntry,
              controller: trxController,
            ),
          ),
        ),
      );
    }
  );
}



class _MovimentoPopupState extends State<MovimentoPopup> {
  DateTime? selectedDate;
  bool isRicorrente = false;
  String? periodicita;
  DateTime? ricStart;
  DateTime? ricEnd;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 4, bottom: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            _buildTextField(widget.controller.nomeController, 'Nome'),
            _buildTextField(widget.controller.importoController, 'Importo'),
            
            // Usa il nuovo DatePicker widget
            DatePicker(
              initialDate: selectedDate,
              onDateSelected: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Entrata Ricorrente', style: TextStyle(fontWeight: FontWeight.w500)),
                Switch(
                  value: isRicorrente,
                  onChanged: (val) => setState(() => isRicorrente = val),
                  activeColor: Colors.green,
                )
              ],
            ),

            if (isRicorrente) ...[
              DropdownButtonFormField<String>(
                value: periodicita,
                items: ['Mensile', 'Settimanale', 'Annuale'].map(
                  (v) => DropdownMenuItem(value: v, child: Text(v))
                ).toList(),
                onChanged: (val) => setState(() => periodicita = val),
                hint: const Text('Periodicità'),
              ),
              DatePicker(
                initialDate: ricStart,
                onDateSelected: (date) => setState(() => ricStart = date),
              ),
              DatePicker(
                initialDate: ricEnd,
                onDateSelected: (date) => setState(() => ricEnd = date),
              ),
            ],
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Imposta la data scelta (singola)
                  final trx = widget.controller.buildTransaction(
                    isEntry: widget.isEntry,
                    categoria: 'CategoriaCorrente',
                    date: selectedDate ?? DateTime.now(),
                    isRicorrente: isRicorrente,
                    periodicita: periodicita,
                    ricStart: ricStart,
                    ricEnd: ricEnd,
                  );

                  print('TRANSACTION DA INSERIRE: ${trx.toMap()}');
                  await widget.controller.addTransaction(trx);
                  print('INSERITO IN DB');
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(widget.textButton, style: buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
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
