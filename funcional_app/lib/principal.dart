import 'package:flutter/material.dart';
import 'package:funcional_app/pages/bottom_nav.dart';
import 'package:funcional_app/pages/rutas.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  BNNavigator? myBBN;
  @override
  void initState() {
    myBBN = BNNavigator(currentIndex: (i) {
      setState(() {
        index = i;
      });
    });

    super.initState();
  }

//Esta seria la barra de navegacion
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: myBBN,
      body: Routes(index: index),
    );
  }
}
