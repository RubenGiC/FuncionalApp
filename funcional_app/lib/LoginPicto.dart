import 'package:flutter/material.dart';


class loginPicto extends StatefulWidget{

  @override
  _loginPictoState createState() => _loginPictoState();
}

class _loginPictoState extends State<loginPicto>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
          body: Container(
            child:GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,

            ),
          ),
          );
  }
}
