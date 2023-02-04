import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: const Text('LISTE DES PRODUITS'),
      ),
      body: Column(
        children: [Text('PRODUITS ITEMS')],
      ),
    );
  }
}
