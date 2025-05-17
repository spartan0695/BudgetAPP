import 'package:flutter/material.dart';
import '../styles.dart';

class AddButtonsMenu extends StatelessWidget {
    final VoidCallback onAddExpense;
    final VoidCallback onOtherAction;

    const AddButtonsMenu({
        super.key,
        required this.onAddExpense,
        required this.onOtherAction,
    });

    @override
    Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: onAddExpense,
          style: primaryButtonStyle, // 🔥 definito in styles.dart
          child: const Text("Entrata"),
        ),
        ElevatedButton(
          onPressed: onOtherAction,
          style: secondaryButtonStyle, // 🔥 definito in styles.dart
          child: const Text("Spesa"),
        ),
      ],
    );
  }
}