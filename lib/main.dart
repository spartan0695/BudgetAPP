import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'transaction_page.dart';
import 'styles.dart';
import 'widgets/add_button_menu.dart';
import 'widgets/transactions_record.dart';
import 'widgets/balance_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override  // This widget is the root of your application.
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme,),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const MyHomePage(title: 'Budget Home App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final List<String> _expenses = [];

  void _incrementCounter() {
    setState(() {
        _counter++;
    });
  }

  void _showTransactions() {
    setState(() {
      _counter=_counter+2;
    });
  }
  void _addExpense() {
    setState(() {
      if (_expenses.length < 4) {
        _expenses.add('Spesa ${_expenses.length + 1}');
      }
    });
  }

  void _insertExpense() {
    print("Spesa inserita");
    _addExpense();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue, // 🔥 Cambia colore di sfondo
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Immagine profilo
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpg'), // 🔥 assicurati che il file sia presente in assets
              radius: 20,
            ),

            // Titolo centrato visivamente (ma resta centrato rispetto allo spazio disponibile)
            const Expanded(
              child: Text(
                'Budget APP',
                textAlign: TextAlign.center,
                style: appBarText,
              ),
            ),

            // Icona impostazioni
            IconButton(
              icon: const Icon(Icons.tune, color: Colors.white),
              onPressed: () {
                // Azione impostazioni
              },
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BalanceCard(), // 🔥 AGGIUNTA: card bilancio totale
            const SizedBox(height: 16), // 🔥 AGGIUNTA: spazio dopo la card
            AddButtonsMenu(
              onAddExpense: _insertExpense,
              onOtherAction: () {print("Altro premuto"); },
            ),
            const SizedBox(height: 16), // 🔥 AGGIUNTA: spazio dopo la card
            TransRecord(),
            const SizedBox(height: 16), // 🔥 AGGIUNTA: spazio dopo la card
            TransRecord(),
            const Text(
              'Spese:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Lista delle spese
            ..._expenses.map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    e,
                    style: const TextStyle(fontSize: 16),
                  ),
                )).toList(),
            const SizedBox(height: 32),
            Center(
              child: Column(
                children: <Widget>[
                  const Text('You have pushed the button this many times:'),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),


      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Pulsante testuale a sinistra
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: ElevatedButton(
              onPressed: () {
                _insertExpense();
                print("Pulsante azzurro premuto");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue, // Sfondo azzurro
                foregroundColor: Colors.white,     // Colore del testo
              ),
              child: const Text("Inserisci Spesa"),
            ),
          ),
                FloatingActionButton(
                  onPressed: _incrementCounter,
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ), 
                
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TransactionsPage()),);
                  },
                  tooltip: 'mostraTransazioni',
                  child: const Icon(Icons.payments, color: Colors.blue),
                ),
              ],
          )
        
         
    );
  }
  }


