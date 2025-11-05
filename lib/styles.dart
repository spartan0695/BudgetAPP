import 'package:flutter/material.dart';

// Colori
const Color primaryColor = Colors.blue;
const Color successColor = Colors.green;
const Color expenseColor = Color.fromARGB(255, 239, 103, 103);
const Color entryColor = Color.fromARGB(255, 91, 210, 95);
const Color backgroundColor = Color(0xFFF5F5F5);
const Color containerColor = Color.fromARGB(255, 60, 158, 163);

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


// -------------------
// -- BILANCIO TOTALE
// -------------------
const TextStyle balanceTitleStyle = TextStyle( //BILANCIO TOTALE_ TESTO 
  fontSize: 16,
  fontWeight: FontWeight.w500,
);
const TextStyle balanceAmountStyle = TextStyle( //BILANCIO TOTALE_ AMOUNT
  fontSize: 28,
  fontWeight: FontWeight.bold,
);

const TextStyle endBalanceTitleStyle = TextStyle( //BILANCIO TOTALE_ TESTO 
  fontSize: 16,
  fontWeight: FontWeight.w500,
);
const TextStyle endBalanceAmountStyle = TextStyle( //BILANCIO TOTALE_ AMOUNT
  fontSize: 26,
  fontWeight: FontWeight.bold,
  color: containerColor,
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

BoxDecoration plusDecoration = BoxDecoration(
  color: successColor,
  borderRadius: BorderRadius.circular(8),
);

BoxDecoration minusDecoration = BoxDecoration(
  color: expenseColor,
  borderRadius: BorderRadius.circular(8),
);



const TextStyle transactionTitleS = TextStyle( //TITOLO transazione //CHECK SE CANCELLARE
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

const TextStyle buttonText = TextStyle( //Testo Pulsante 
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: Colors.white,
);

const TextStyle transactionDateS = TextStyle( //DATA transazione //CHECK SE CANCELLARE
  fontSize: 12,
  fontWeight: FontWeight.w500,
);

const TextStyle transactionAmountS = TextStyle( //IMPORTO transazione //CHECK SE CANCELLARE
  fontSize: 16,
  color: Colors.white,
  fontWeight: FontWeight.w500,
);

const TextStyle percentStyle = TextStyle(
  color: Colors.white,
);



// -- PULSANTI

final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: entryColor,
  foregroundColor: Colors.white,
  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 2),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
);

final ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: expenseColor,
  foregroundColor: Colors.white,
  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 2),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
);