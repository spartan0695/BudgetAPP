import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../providers/balance_provider.dart';
import '../balance_page.dart';

/// Schermata di onboarding mostrata al primo avvio dell'app
/// Chiede all'utente di inserire il saldo iniziale
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Controller per gestire l'input del saldo
  final TextEditingController _saldoController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    // Mostra il dialog appena la schermata è stata costruita
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showInitialBalanceDialog();
    });
  }
  
  /// Mostra il dialog per inserire il saldo iniziale
  Future<void> _showInitialBalanceDialog() async {
    return showDialog(
      context: context,
      // Impedisce di chiudere il dialog toccando fuori
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Benvenuto in BudgetAPP! 👋'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Per iniziare, inserisci il tuo saldo attuale:',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _saldoController,
                // Tastiera numerica con supporto decimali
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Saldo iniziale',
                  prefixText: '€ ',
                  border: OutlineInputBorder(),
                  hintText: '0.00',
                ),
                // Focus automatico sul campo
                autofocus: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // Converti il testo in numero (se vuoto usa 0.0)
                double saldoIniziale = double.tryParse(_saldoController.text) ?? 0.0;
                
                // Accedi al BalanceProvider e salva il saldo iniziale
                // Usa 'listen: false' perché non serve ascoltare i cambiamenti
                final balanceProvider = Provider.of<BalanceProvider>(context, listen: false);
                
                // Chiama il metodo del provider per impostare il saldo iniziale
                // (Assicurati che questo metodo esista nel tuo BalanceProvider)
                await balanceProvider.setSaldoIniziale(saldoIniziale);
                
                // Salva la flag in SharedPreferences per indicare che l'app è stata inizializzata
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isFirstLaunch', false);
                
                // Chiudi il dialog
                if (mounted) {
                  Navigator.of(context).pop();
                  
                  // Naviga alla schermata principale
                  Navigator.of(context).pushReplacementNamed('/');
                }
              },
              child: const Text(
                'Conferma',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
  
  @override
  void dispose() {
    // Libera le risorse del controller quando non serve più
    _saldoController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    // Mostra un indicatore di caricamento mentre il dialog si apre
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
