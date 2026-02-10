import 'package:flutter/material.dart';
import '../providers/theme_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/balance_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Impostazioni'),
      ),
      body: ListView(
        children: [
          // Sezione Account
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Account',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (!authProvider.isLoggedIn)
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Accedi con Google'),
              subtitle: const Text('Sincronizza i tuoi dati nel cloud'),
              onTap: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(child: CircularProgressIndicator()),
                );
                try {
                  await authProvider.loginWithGoogle();
                  if (authProvider.isLoggedIn) {
                    await Provider.of<BalanceProvider>(context, listen: false).syncFromCloud();
                  }
                } catch (e) {
                  print("ERRORE DURANTE IL LOGIN: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Errore durante il login: $e")),
                  );
                } finally {
                  Navigator.pop(context); // Chiude il caricamento
                }
              },
            )
          else
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(authProvider.userName ?? 'Utente'),
              subtitle: Text(authProvider.userEmail ?? ''),
              trailing: IconButton(
                icon: const Icon(Icons.logout, color: Colors.red),
                onPressed: () => authProvider.logout(),
              ),
            ),
          
          const Divider(),

          // Sezione Aspetto
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Aspetto',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.brightness_auto),
            title: const Text('Tema di sistema'),
            trailing: Radio<ThemeMode>(
              value: ThemeMode.system,
              groupValue: themeProvider.themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) themeProvider.setThemeMode(value);
              },
            ),
            onTap: () => themeProvider.setThemeMode(ThemeMode.system),
          ),
          ListTile(
            leading: const Icon(Icons.light_mode),
            title: const Text('Tema chiaro'),
            trailing: Radio<ThemeMode>(
              value: ThemeMode.light,
              groupValue: themeProvider.themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) themeProvider.setThemeMode(value);
              },
            ),
            onTap: () => themeProvider.setThemeMode(ThemeMode.light),
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Tema scuro'),
            trailing: Radio<ThemeMode>(
              value: ThemeMode.dark,
              groupValue: themeProvider.themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) themeProvider.setThemeMode(value);
              },
            ),
            onTap: () => themeProvider.setThemeMode(ThemeMode.dark),
          ),
        ],
      ),
    );
  }
}