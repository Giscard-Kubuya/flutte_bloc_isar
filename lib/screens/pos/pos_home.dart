import 'package:flutter/material.dart';

class PosHome extends StatelessWidget {
  const PosHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: const Text('LISTE DES VENTES'),
      ),
      body: Center(
        child: Column(
          children: [Text('COMMAND ITEMS')],
        ),
      ),
    );
  }
}
