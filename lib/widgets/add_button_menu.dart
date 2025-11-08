import 'package:flutter/material.dart';
import '../styles.dart';

class AddButtonsMenu extends StatelessWidget {
    final VoidCallback onAddEntry;
    final VoidCallback onAddExpense;

    const AddButtonsMenu({
        super.key,
        required this.onAddEntry,
        required this.onAddExpense,
    });

    @override
    Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: onAddEntry,
          style: primaryButtonStyle, // 🔥 definito in styles.dart
          child: const Text("Entrata", style: buttonText),
        ),
        ElevatedButton(
          onPressed: onAddExpense,
          style: secondaryButtonStyle, // 🔥 definito in styles.dart
          child: const Text("Uscita", style: buttonText),
        ),
      ],
    );
  }
}