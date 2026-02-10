import 'package:flutter/material.dart';
import 'styles.dart';

final darkStyles = AppCustomStyles(
  primaryColor: Colors.blueGrey,
  successColor: Colors.greenAccent,
  expenseColor: const Color.fromARGB(255, 255, 120, 120),
  entryColor: const Color.fromARGB(255, 110, 230, 115),
  backgroundColor: const Color(0xFF121212),
  containerColor: const Color.fromARGB(255, 45, 120, 125),
  headingStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
  appBarText: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
  balanceTitleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white70),
  balanceAmountStyle: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
  endBalanceTitleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white70),
  endBalanceAmountStyle: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 110, 230, 115)),
  cardDecoration: BoxDecoration(
    color: const Color(0xFF1E1E1E),
    borderRadius: BorderRadius.circular(16),
    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), spreadRadius: 2, blurRadius: 5)],
  ),
  plusDecoration: BoxDecoration(color: Colors.greenAccent, borderRadius: BorderRadius.circular(8)),
  minusDecoration: BoxDecoration(color: const Color.fromARGB(255, 255, 120, 120), borderRadius: BorderRadius.circular(8)),
  transactionTitleS: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
  buttonText: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
  transactionDateS: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white60),
  transactionAmountS: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
  percentStyle: const TextStyle(color: Colors.white),
  primaryButtonStyle: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 110, 230, 115),
    foregroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  ),
  secondaryButtonStyle: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 255, 120, 120),
    foregroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  ),
  entryDecoration: BoxDecoration(
    color: const Color.fromARGB(255, 45, 120, 125),
    borderRadius: BorderRadius.circular(8),
  ),
  transactionTitleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
  transactionStatusStyle: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 45, 120, 125), fontWeight: FontWeight.bold),
  transactionDateStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white60),
);
