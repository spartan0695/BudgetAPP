import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/balance_provider.dart'; 
import '../styles.dart';

class MonthlyOverviewCard extends StatefulWidget {
  final int monthOffset;
  final bool initiallyExpanded;
  final bool isExpandable;

  const MonthlyOverviewCard({
    super.key,
    this.monthOffset = 0,
    this.initiallyExpanded = true,
    this.isExpandable = false,
  });

  @override
  State<MonthlyOverviewCard> createState() => _MonthlyOverviewCardState();
}

class _MonthlyOverviewCardState extends State<MonthlyOverviewCard> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final balanceProvider = Provider.of<BalanceProvider>(context);
    final s = appStyles(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final targetDate = DateTime(DateTime.now().year, DateTime.now().month + widget.monthOffset);
    
    double projection;
    if (widget.monthOffset == 0) {
      projection = balanceProvider.endMonthBalance;
    } else if (widget.monthOffset == 1) {
      projection = balanceProvider.endMonth2Balance;
    } else {
      projection = balanceProvider.endMonth3Balance;
    }

    final incomes = balanceProvider.monthlyIncomesForMonth(targetDate.month, targetDate.year);
    final outgoings = balanceProvider.monthlyOutgoingsForMonth(targetDate.month, targetDate.year);
    final savings = balanceProvider.totalSavingsForMonth(targetDate.month, targetDate.year);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: s.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header (si clicca per espandere se isExpandable è true)
          InkWell(
            onTap: widget.isExpandable ? () => setState(() => _isExpanded = !_isExpanded) : null,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: s.containerColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    'Prospettiva ${_getMonthName(targetDate)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                if (widget.isExpandable) ...[
                  const Spacer(),
                  Icon(_isExpanded ? Icons.expand_less : Icons.expand_more, color: isDark ? Colors.white70 : Colors.grey),
                ],
              ],
            ),
          ),

          if (!_isExpanded) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Fine mese', style: TextStyle(fontSize: 16)),
                const Spacer(),
                Text(
                  '${projection.toStringAsFixed(2)} €',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: s.containerColor),
                ),
              ],
            ),
          ],

          if (_isExpanded) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  widget.monthOffset == 0 ? 'Fine mese attuale ' : 'Fine mese ',
                  style: const TextStyle(fontSize: 18),
                ),
                const Spacer(),
                Text(
                  '${projection.toStringAsFixed(2)} €',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: s.containerColor,
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),

            const SizedBox(height: 16),
            const Text(
              'Risparmio Totale',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(
              '${savings.toStringAsFixed(2)} €',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),

            const SizedBox(height: 6),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: s.entryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                '+50,0%', 
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Entrate e Uscite:
            Row(
              children: [
                Icon(Icons.arrow_upward, color: s.entryColor, size: 26),
                const SizedBox(width: 8),
                const Text(
                  'Entrate',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const Spacer(),
                Text(
                  '+${incomes.toStringAsFixed(2)} €',
                  style: TextStyle(
                    color: s.entryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            Row(
              children: [
                Icon(Icons.arrow_downward, color: s.expenseColor, size: 26),
                const SizedBox(width: 8),
                const Text(
                  'Uscite',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const Spacer(),
                Text(
                  '-${outgoings.toStringAsFixed(2)} €',
                  style: TextStyle(
                    color: s.expenseColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'Visualizza Dettagli ▼',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: isDark ? Colors.white70 : Colors.black54),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getMonthName(DateTime date) {
    const months = [
      'Gennaio', 'Febbraio', 'Marzo', 'Aprile', 'Maggio', 'Giugno',
      'Luglio', 'Agosto', 'Settembre', 'Ottobre', 'Novembre', 'Dicembre'
    ];
    return months[date.month - 1];
  }
}
