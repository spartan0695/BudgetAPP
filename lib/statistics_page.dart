import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/monthly_overview_card.dart'; // Aggiorna il path se necessario

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            // Primo mese (già esistente, espanso di default)
            const MonthlyOverviewCard(
              monthOffset: 0,
              initiallyExpanded: true,
              isExpandable: true,
            ),
            
            // Secondo mese (chiuso di default, espandibile)
            const MonthlyOverviewCard(
              monthOffset: 1,
              initiallyExpanded: false,
              isExpandable: true,
            ),

            // Terzo mese (chiuso di default, espandibile)
            const MonthlyOverviewCard(
              monthOffset: 2,
              initiallyExpanded: false,
              isExpandable: true,
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
