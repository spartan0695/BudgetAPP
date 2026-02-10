import 'package:budget_app/balance_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'transaction_page.dart';
import 'styles.dart';
import 'widgets/add_button_menu.dart';
import 'widgets/transactions_record.dart';
import 'widgets/balance_card.dart';
import 'widgets/app_Bar.dart';
import 'widgets/NOTUSEDadd_entry_popup.dart';
import 'widgets/popup_add.dart';
import 'widgets/footer_menu.dart';
import 'widgets/onboarding_screen.dart'; // Importa il nuovo widget
import 'statistics_page.dart';
import 'notificationsSetup_page.dart';
import 'settings_page.dart';
import 'balance_page.dart';
import 'premium_page.dart';
import 'services/premium_service.dart';
import 'package:provider/provider.dart';
import 'providers/balance_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/auth_provider.dart';
import 'styles.dart';
import 'dark_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
//import 'package:sqflite_common_ffi/sqflite_ffi.dart';


/// Funzione principale dell'app
/// Inizializza i servizi necessari prima di avviare l'app
void main() async {
  // Assicura che i binding di Flutter siano inizializzati
  // Necessario quando si usano operazioni asincrone nel main
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inizializza Firebase
  await Firebase.initializeApp();

  // Inizializza localizzazione date
  await initializeDateFormatting('it', null);
  
  // Ottiene l'istanza di SharedPreferences per leggere i dati salvati
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Controlla se è il primo avvio dell'app
  // Se la chiave 'isFirstLaunch' non esiste, ritorna true (primo avvio)
  bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
  
  // Inizializza il servizio premium
  await PremiumService().init();
  
  // Avvia l'app con i provider necessari
  runApp(
    MultiProvider(
      providers: [
        // Provider per gestire lo stato del saldo
        ChangeNotifierProvider(create: (_) => BalanceProvider()),
        // Provider per gestire il tema
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        // Provider per l'autenticazione
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MyApp(isFirstLaunch: isFirstLaunch), // Passa la flag al widget principale
    ),
  );
}


/// Widget principale dell'applicazione
/// Gestisce la configurazione globale dell'app (tema, routes, ecc.)
class MyApp extends StatelessWidget {
  // Flag che indica se è il primo avvio
  final bool isFirstLaunch;
  
  const MyApp({super.key, required this.isFirstLaunch});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Budget App',
          themeMode: themeProvider.themeMode,
          
          // Imposta il tema Light
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            textTheme: GoogleFonts.montserratTextTheme(
              Theme.of(context).textTheme,
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 241, 241, 241),
              brightness: Brightness.light,
            ),
            extensions: [lightStyles],
          ),

          // Imposta il tema Dark
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            textTheme: GoogleFonts.montserratTextTheme(
              Theme.of(context).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blueGrey,
              brightness: Brightness.dark,
            ),
            extensions: [darkStyles],
          ),
          
          // Definisce la route iniziale in base al primo avvio
          // Se è il primo avvio mostra l'onboarding, altrimenti la home
          initialRoute: isFirstLaunch ? '/onboarding' : '/',
          
          // Definisce tutte le route dell'app
          routes: {
            // Route principale - Homepage con la navigazione
            '/': (context) => const MyHomePage(title: 'Budget Home App'),
            
            // Route per l'onboarding (primo avvio)
            '/onboarding': (context) => const OnboardingScreen(),
            
            // Route per la pagina premium
            '/premium': (context) => PremiumPage(),
          },
        );
      },
    );
  }
}


/// Widget della homepage con il menu di navigazione
/// Gestisce la navigazione tra le diverse sezioni dell'app
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  // Indice della pagina selezionata nel menu di navigazione
  int _selectedIndex = 0;
  
  // Lista delle pagine disponibili nell'app
  static const List<Widget> _pages = <Widget>[
    BalancePage(),           // Pagina del saldo
    StatisticsPage(),        // Pagina delle statistiche
    TransactionsPage(),      // Pagina delle transazioni
    NotificationsSetupPage(), // Pagina delle notifiche
    SettingsPage(),          // Pagina delle impostazioni
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar personalizzata
      appBar: CustomAppBar(title: 'BudgetAPP', heightApp: 40),
      
      // Mostra la pagina corrente in base all'indice selezionato
      body: _pages[_selectedIndex],
      
      // Menu di navigazione in basso
      bottomNavigationBar: FooterMenu(
        currentIndex: _selectedIndex,
        // Callback quando viene premuto un elemento del menu
        onTap: (int index) {
          setState(() {
            _selectedIndex = index; // Aggiorna l'indice per cambiare pagina
          });
        },
      ),
    );
  }
}
