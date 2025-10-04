import 'package:flutter/material.dart';
import '../styles.dart';


BoxDecoration entryDecoration = BoxDecoration(
  color: successColor,
  borderRadius: BorderRadius.circular(8),
);

const TextStyle transactionTitleStyle = TextStyle( //TITOLO transazione
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

const TextStyle transactionDateStyle = TextStyle( //DATA transazione
  fontSize: 12,
  fontWeight: FontWeight.w500,
);

const TextStyle transactionAmountStyle = TextStyle( //IMPORTO transazione
  fontSize: 16,
  color: Colors.white,
  fontWeight: FontWeight.w500,
);