import 'package:budget_app/balance_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'transaction_page.dart';
import 'styles.dart';
import 'widgets/add_button_menu.dart';
import 'widgets/transactions_record.dart';
import 'widgets/balance_card.dart';
import 'widgets/app_Bar.dart';
import 'widgets/add_entry_popup.dart';
import 'widgets/popup_add.dart';
import 'widgets/footer_menu.dart';
import 'statistics_page.dart';
import 'notificationsSetup_page.dart';
import 'settings_page.dart';
import 'balance_page.dart';
import 'premium_page.dart';
import 'services/premium_service.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PremiumService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override  // This widget is the root of your application.
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const MyHomePage(title: 'Budget Home App'),
        '/premium': (context) => PremiumPage(),
        // '/advanced': ... la tua pagina avanzata
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme,),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 241, 241, 241)),
      ),
      //home: const MyHomePage(title: 'Budget Home App'),
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
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    BalancePage(),
    StatisticsPage(),
    TransactionsPage(),
    NotificationsSetupPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'BudgetAPP', heightApp: 60),     
      body: _pages[_selectedIndex],
      bottomNavigationBar: FooterMenu(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}


