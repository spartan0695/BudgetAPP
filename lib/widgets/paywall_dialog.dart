import 'package:flutter/material.dart';

class PaywallDialog extends StatelessWidget {
  final VoidCallback? onShowPremiumPage; // Funzione da chiamare quando l’utente clicca su “Scopri Premium”

  const PaywallDialog({Key? key, this.onShowPremiumPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.lock,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              const Text(
                'Funzionalità Premium',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Questa funzione è disponibile solo nella versione Premium.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              _buildFeatureList(),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).pop(); // Chiudi il dialog
                  if (onShowPremiumPage != null) {
                    onShowPremiumPage!(); // Vai alla pagina Premium
                  }
                },
                icon: const Icon(Icons.star),
                label: const Text('Scopri Premium'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Forse più tardi'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureList() {
    final features = [
      '✨ Transazioni ricorrenti illimitate',
      '📊 Proiezioni future avanzate',
      '📈 Statistiche dettagliate',
      '☁️ Backup cloud',
      '📄 Export PDF',
      '🛡️ Supporto prioritario',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: features.map((e) => _featureItem(e)).toList(),
    );
  }

  Widget _featureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, size: 16, color: Colors.amber),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
