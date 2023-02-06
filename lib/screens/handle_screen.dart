import 'package:flutter/material.dart';
import 'pos/pos_home.dart';
import 'categories/categories_screen.dart';
import 'products/products_screen.dart';

class HandleScreen extends StatefulWidget {
  const HandleScreen({Key? key}) : super(key: key);

  @override
  State<HandleScreen> createState() => _HandleScreenState();
}

class _HandleScreenState extends State<HandleScreen> {
  int _selectedWidgetIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeInit(),
    ProductInit(),
    CategoryInit(),
  ];

  void _onWidgetChosen(int indexChosen) {
    setState(() {
      _selectedWidgetIndex = indexChosen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedWidgetIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.workspaces_outline), label: 'Prod'),
          BottomNavigationBarItem(icon: Icon(Icons.zoom_in_map), label: 'Cat'),
        ],
        currentIndex: _selectedWidgetIndex,
        selectedItemColor: const Color.fromARGB(255, 164, 174, 218),
        onTap: _onWidgetChosen,
      ),
    );
  }
}
