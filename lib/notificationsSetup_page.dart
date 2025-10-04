import 'package:flutter/material.dart';

class NotificationsSetupPage extends StatelessWidget{
    const NotificationsSetupPage({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Notifiche'),
            ),
            body: const Center(
                child: Text('Qui potrai modificare le notifiche', style: TextStyle(fontSize: 18),),
            ),
        );
    }
}