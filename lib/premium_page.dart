import 'package:flutter/material.dart';
import 'services/subscription_service.dart';

class PremiumPage extends StatelessWidget {
  final SubscriptionService _subscriptionService = SubscriptionService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget PRO'),
        backgroundColor: Colors.amber[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildFeaturesList(),
            _buildPricingCard(context),
            _buildFAQ(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber[700]!, Colors.amber[500]!],
        ),
      ),
      child: Column(
        children: [
          Icon(Icons.star, size: 80, color: Colors.white),
          SizedBox(height: 16),
          Text(
            'Sblocca Tutte le Funzionalità',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Gestisci il tuo budget senza limiti',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      {'icon': Icons.repeat, 'title': 'Transazioni Ricorrenti Illimitate'},
      {'icon': Icons.trending_up, 'title': 'Proiezioni Future Avanzate'},
      {'icon': Icons.analytics, 'title': 'Statistiche Dettagliate'},
      {'icon': Icons.cloud_upload, 'title': 'Backup Cloud Automatico'},
      {'icon': Icons.picture_as_pdf, 'title': 'Export PDF Report'},
      {'icon': Icons.devices, 'title': 'Sincronizzazione Multi-Device'},
      {'icon': Icons.category, 'title': 'Categorie Personalizzate Illimitate'},
      {'icon': Icons.notifications_active, 'title': 'Notifiche Smart'},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: features.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(features[index]['icon'] as IconData, color: Colors.amber[700]),
          title: Text(features[index]['title'] as String),
        );
      },
    );
  }

  Widget _buildPricingCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber[700]!, width: 2),
      ),
      child: Column(
        children: [
          Text(
            '€1,99',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.amber[900],
            ),
          ),
          Text('al mese', style: TextStyle(fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'Cancella in qualsiasi momento',
            style: TextStyle(color: Colors.grey[600]),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              await _subscriptionService.purchasePremium();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber[700],
              padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Inizia Ora',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQ() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Domande Frequenti',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _faqItem('Posso cancellare?', 'Sì, in qualsiasi momento dalle impostazioni'),
          _faqItem('Funziona offline?', 'Sì, tutte le funzionalità sono disponibili offline'),
          _faqItem('I dati sono sicuri?', 'Sì, crittografia end-to-end per backup cloud'),
        ],
      ),
    );
  }

  Widget _faqItem(String question, String answer) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(answer, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
    );
  }
}
