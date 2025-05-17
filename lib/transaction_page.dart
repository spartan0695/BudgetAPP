import 'package:flutter/material.dart';

class TransactionsPage extends StatelessWidget{
    const TransactionsPage({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Transazioni'),
            ),
            body: const Center(
                child: Text('Qui verranno mostrate le transazioni', style: TextStyle(fontSize: 18),),
            ),
        );
    }
}