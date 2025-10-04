import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget{
    const SettingsPage({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Impostazioni'),
            ),
            body: const Center(
                child: Text('Qui potrai impostare tutto', style: TextStyle(fontSize: 18),),
            ),
        );
    }
}