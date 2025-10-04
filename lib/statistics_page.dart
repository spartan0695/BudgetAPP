import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget{
    const StatisticsPage({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            //appBar: AppBar(title: const Text('Statistiche'),),
            body: const Center(
                child: Text('Qui verranno mostrate le statistiche', style: TextStyle(fontSize: 18),),
            ),
        );
    }
}