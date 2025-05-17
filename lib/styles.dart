import 'package:flutter/material.dart';

// Colori
const Color primaryColor = Colors.blue;
const Color successColor = Colors.green;
const Color backgroundColor = Color(0xFFF5F5F5);

// Testi
const TextStyle headingStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const TextStyle appBarText = TextStyle( //APPBAR testo
  fontSize: 20, 
  fontWeight: FontWeight.bold,
  color: Colors.white
);

const TextStyle balanceTitleStyle = TextStyle( //BILANCIO TOTALE TESTO 
  fontSize: 16,
  fontWeight: FontWeight.w500,
);
const TextStyle balanceAmountStyle = TextStyle( //BILANCIO TOTALE AMOUNT
  fontSize: 28,
  fontWeight: FontWeight.bold,
);

const TextStyle transactionTitle = TextStyle( //TITOLO transazione
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

const TextStyle transactionDate = TextStyle( //DATA transazione
  fontSize: 12,
  fontWeight: FontWeight.w500,
);

const TextStyle transactionAmount = TextStyle( //DATA transazione
  fontSize: 16,
  color: Colors.white,
  fontWeight: FontWeight.w500,
);

const TextStyle percentStyle = TextStyle(
  color: Colors.white,
);


// Decorazioni
BoxDecoration cardDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(16),
  boxShadow: [
    BoxShadow(
      color: const Color.fromARGB(255, 216, 216, 216),
      spreadRadius: 2,
      blurRadius: 5,
    ),
  ],
);

final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.green,
  foregroundColor: Colors.white,
  padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 12),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
);

final ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.red,
  foregroundColor: Colors.white,
  padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 12),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
);