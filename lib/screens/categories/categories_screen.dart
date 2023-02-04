import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: const Text('LISTE DES CATEGORIES'),
      ),
      body: Column(
        children: [Text('CATEGORIES ITEMS')],
      ),
    );
  }
}
