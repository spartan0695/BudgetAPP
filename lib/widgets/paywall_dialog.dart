import 'package:flutter/material.dart';

class PaywallDialog extends StatelessWidget {
  final String featureName;
  final VoidCallback onUpgrade;

  const PaywallDialog({
    Key? key,
    required this.featureName,
    required this.onUpgrade,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lock,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 16),
            Text(
              'Funzionalità Premium',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              '$featureName è disponibile solo nella versione Premium',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            _buildFeatureList(),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: onUpgrade,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star),
                  SizedBox(width: 8),
                  Text('Passa a Premium - €1,99/mese'),
                ],
              ),
            ),
            SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Forse più tardi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _featureItem('✨ Transazioni ricorrenti illimitate'),
        _featureItem('📊 Statistiche avanzate'),
        _featureItem('☁️ Backup automatico'),
        _featureItem('📱 Sincronizzazione multi-device'),
        _featureItem('📈 Proiezioni future illimitate'),
      ],
    );
  }

  Widget _featureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text('  $text', style: TextStyle(fontSize: 14)),
    );
  }
}
