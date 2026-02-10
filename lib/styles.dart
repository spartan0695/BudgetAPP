import 'package:flutter/material.dart';

@immutable
class AppCustomStyles extends ThemeExtension<AppCustomStyles> {
  final Color primaryColor;
  final Color successColor;
  final Color expenseColor;
  final Color entryColor;
  final Color backgroundColor;
  final Color containerColor;
  final TextStyle headingStyle;
  final TextStyle appBarText;
  final TextStyle balanceTitleStyle;
  final TextStyle balanceAmountStyle;
  final TextStyle endBalanceTitleStyle;
  final TextStyle endBalanceAmountStyle;
  final BoxDecoration cardDecoration;
  final BoxDecoration plusDecoration;
  final BoxDecoration minusDecoration;
  final TextStyle transactionTitleS;
  final TextStyle buttonText;
  final TextStyle transactionDateS;
  final TextStyle transactionAmountS;
  final TextStyle percentStyle;
  final ButtonStyle primaryButtonStyle;
  final ButtonStyle secondaryButtonStyle;
  
  // Aggiunti da transactionStyle.dart
  final BoxDecoration entryDecoration;
  final TextStyle transactionTitleStyle;
  final TextStyle transactionStatusStyle;
  final TextStyle transactionDateStyle;

  const AppCustomStyles({
    required this.primaryColor,
    required this.successColor,
    required this.expenseColor,
    required this.entryColor,
    required this.backgroundColor,
    required this.containerColor,
    required this.headingStyle,
    required this.appBarText,
    required this.balanceTitleStyle,
    required this.balanceAmountStyle,
    required this.endBalanceTitleStyle,
    required this.endBalanceAmountStyle,
    required this.cardDecoration,
    required this.plusDecoration,
    required this.minusDecoration,
    required this.transactionTitleS,
    required this.buttonText,
    required this.transactionDateS,
    required this.transactionAmountS,
    required this.percentStyle,
    required this.primaryButtonStyle,
    required this.secondaryButtonStyle,
    required this.entryDecoration,
    required this.transactionTitleStyle,
    required this.transactionStatusStyle,
    required this.transactionDateStyle,
  });

  @override
  AppCustomStyles copyWith({
    Color? primaryColor,
    Color? successColor,
    Color? expenseColor,
    Color? entryColor,
    Color? backgroundColor,
    Color? containerColor,
    TextStyle? headingStyle,
    TextStyle? appBarText,
    TextStyle? balanceTitleStyle,
    TextStyle? balanceAmountStyle,
    TextStyle? endBalanceTitleStyle,
    TextStyle? endBalanceAmountStyle,
    BoxDecoration? cardDecoration,
    BoxDecoration? plusDecoration,
    BoxDecoration? minusDecoration,
    TextStyle? transactionTitleS,
    TextStyle? buttonText,
    TextStyle? transactionDateS,
    TextStyle? transactionAmountS,
    TextStyle? percentStyle,
    ButtonStyle? primaryButtonStyle,
    ButtonStyle? secondaryButtonStyle,
    BoxDecoration? entryDecoration,
    TextStyle? transactionTitleStyle,
    TextStyle? transactionStatusStyle,
    TextStyle? transactionDateStyle,
  }) {
    return AppCustomStyles(
      primaryColor: primaryColor ?? this.primaryColor,
      successColor: successColor ?? this.successColor,
      expenseColor: expenseColor ?? this.expenseColor,
      entryColor: entryColor ?? this.entryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      containerColor: containerColor ?? this.containerColor,
      headingStyle: headingStyle ?? this.headingStyle,
      appBarText: appBarText ?? this.appBarText,
      balanceTitleStyle: balanceTitleStyle ?? this.balanceTitleStyle,
      balanceAmountStyle: balanceAmountStyle ?? this.balanceAmountStyle,
      endBalanceTitleStyle: endBalanceTitleStyle ?? this.endBalanceTitleStyle,
      endBalanceAmountStyle: endBalanceAmountStyle ?? this.endBalanceAmountStyle,
      cardDecoration: cardDecoration ?? this.cardDecoration,
      plusDecoration: plusDecoration ?? this.plusDecoration,
      minusDecoration: minusDecoration ?? this.minusDecoration,
      transactionTitleS: transactionTitleS ?? this.transactionTitleS,
      buttonText: buttonText ?? this.buttonText,
      transactionDateS: transactionDateS ?? this.transactionDateS,
      transactionAmountS: transactionAmountS ?? this.transactionAmountS,
      percentStyle: percentStyle ?? this.percentStyle,
      primaryButtonStyle: primaryButtonStyle ?? this.primaryButtonStyle,
      secondaryButtonStyle: secondaryButtonStyle ?? this.secondaryButtonStyle,
      entryDecoration: entryDecoration ?? this.entryDecoration,
      transactionTitleStyle: transactionTitleStyle ?? this.transactionTitleStyle,
      transactionStatusStyle: transactionStatusStyle ?? this.transactionStatusStyle,
      transactionDateStyle: transactionDateStyle ?? this.transactionDateStyle,
    );
  }

  @override
  AppCustomStyles lerp(ThemeExtension<AppCustomStyles>? other, double t) {
    if (other is! AppCustomStyles) return this;
    return AppCustomStyles(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      expenseColor: Color.lerp(expenseColor, other.expenseColor, t)!,
      entryColor: Color.lerp(entryColor, other.entryColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      containerColor: Color.lerp(containerColor, other.containerColor, t)!,
      headingStyle: TextStyle.lerp(headingStyle, other.headingStyle, t)!,
      appBarText: TextStyle.lerp(appBarText, other.appBarText, t)!,
      balanceTitleStyle: TextStyle.lerp(balanceTitleStyle, other.balanceTitleStyle, t)!,
      balanceAmountStyle: TextStyle.lerp(balanceAmountStyle, other.balanceAmountStyle, t)!,
      endBalanceTitleStyle: TextStyle.lerp(endBalanceTitleStyle, other.endBalanceTitleStyle, t)!,
      endBalanceAmountStyle: TextStyle.lerp(endBalanceAmountStyle, other.endBalanceAmountStyle, t)!,
      cardDecoration: BoxDecoration.lerp(cardDecoration, other.cardDecoration, t)!,
      plusDecoration: BoxDecoration.lerp(plusDecoration, other.plusDecoration, t)!,
      minusDecoration: BoxDecoration.lerp(minusDecoration, other.minusDecoration, t)!,
      transactionTitleS: TextStyle.lerp(transactionTitleS, other.transactionTitleS, t)!,
      buttonText: TextStyle.lerp(buttonText, other.buttonText, t)!,
      transactionDateS: TextStyle.lerp(transactionDateS, other.transactionDateS, t)!,
      transactionAmountS: TextStyle.lerp(transactionAmountS, other.transactionAmountS, t)!,
      percentStyle: TextStyle.lerp(percentStyle, other.percentStyle, t)!,
      primaryButtonStyle: ButtonStyle.lerp(primaryButtonStyle, other.primaryButtonStyle, t)!,
      secondaryButtonStyle: ButtonStyle.lerp(secondaryButtonStyle, other.secondaryButtonStyle, t)!,
      entryDecoration: BoxDecoration.lerp(entryDecoration, other.entryDecoration, t)!,
      transactionTitleStyle: TextStyle.lerp(transactionTitleStyle, other.transactionTitleStyle, t)!,
      transactionStatusStyle: TextStyle.lerp(transactionStatusStyle, other.transactionStatusStyle, t)!,
      transactionDateStyle: TextStyle.lerp(transactionDateStyle, other.transactionDateStyle, t)!,
    );
  }
}

// Helper per accedere agli stili più facilmente
AppCustomStyles appStyles(BuildContext context) => Theme.of(context).extension<AppCustomStyles>()!;

// Istanza Light
final lightStyles = AppCustomStyles(
  primaryColor: Colors.blue,
  successColor: Colors.green,
  expenseColor: const Color.fromARGB(255, 239, 103, 103),
  entryColor: const Color.fromARGB(255, 91, 210, 95),
  backgroundColor: const Color(0xFFF5F5F5),
  containerColor: const Color.fromARGB(255, 60, 158, 163),
  headingStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  appBarText: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
  balanceTitleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  balanceAmountStyle: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
  endBalanceTitleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  endBalanceAmountStyle: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 60, 158, 163)),
  cardDecoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: const [BoxShadow(color: Color.fromARGB(255, 216, 216, 216), spreadRadius: 2, blurRadius: 5)],
  ),
  plusDecoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8)),
  minusDecoration: BoxDecoration(color: const Color.fromARGB(255, 239, 103, 103), borderRadius: BorderRadius.circular(8)),
  transactionTitleS: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  buttonText: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
  transactionDateS: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
  transactionAmountS: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
  percentStyle: const TextStyle(color: Colors.white),
  primaryButtonStyle: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 91, 210, 95),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  ),
  secondaryButtonStyle: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 239, 103, 103),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  ),
  entryDecoration: BoxDecoration(
    color: const Color.fromARGB(255, 60, 158, 163),
    borderRadius: BorderRadius.circular(8),
  ),
  transactionTitleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  transactionStatusStyle: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 60, 158, 163), fontWeight: FontWeight.bold),
  transactionDateStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
);