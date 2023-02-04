import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store/screens/handle_screen.dart';

void main() {
  runApp(const InitStore());
}

class InitStore extends StatelessWidget {
  const InitStore({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'STORE APP',
      debugShowCheckedModeBanner: false,
      home: HandleScreen(),
    );
  }
}
