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
    final s = appStyles(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: onAddEntry,
          style: s.primaryButtonStyle,
          child: Text("Entrata", style: s.buttonText),
        ),
        ElevatedButton(
          onPressed: onAddExpense,
          style: s.secondaryButtonStyle,
          child: Text("Uscita", style: s.buttonText),
        ),
      ],
    );
  }
}