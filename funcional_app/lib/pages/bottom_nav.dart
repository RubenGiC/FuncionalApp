import 'package:flutter/material.dart';

class BNNavigator extends StatefulWidget {
  final Function currentIndex;
  const BNNavigator({super.key, required this.currentIndex});

  @override
  State<BNNavigator> createState() => _BNNavigatorState();
}

class _BNNavigatorState extends State<BNNavigator> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: index,
        onTap: (int i) {
          setState(() {
            index = i;
            widget.currentIndex(i);
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        iconSize: 25.0,
        selectedFontSize: 15.0,
        unselectedFontSize: 12.0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle_sharp),
              label: 'Usuarios'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_sharp), label: 'Tareas'),
          BottomNavigationBarItem(
              icon: Icon(Icons.inventory), label: 'Inventario'),
          //BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio')
        ]);
  }
}
