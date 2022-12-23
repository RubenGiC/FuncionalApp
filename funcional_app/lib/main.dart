import 'package:flutter/material.dart';
import 'package:funcional_app/models/categoria.dart';
import 'package:funcional_app/LoginEstandar.dart';
import 'package:funcional_app/LoginPicto.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Funcional App',
      debugShowCheckedModeBanner:
          false, //elimina la cinta debug de la esquina superior derecha
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Escolar',
      ),
      home: Container(
        child: PantallaInicio(),
      ),
    );
  }
}

class PantallaInicio extends StatefulWidget {
  @override
  _PantallaInicioState createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TIPO DE INICIO DE SESION",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontFamily: 'Escolar')),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.blue[100],
      body: Container(
          child: GridView.builder(
              itemCount: Menu.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        switch (Menu[index].id) {
                          case 1:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => loginPicto()));
                            break;
                          case 4:
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => login()));
                            break;
                        }

                        //print("click en "+Menu[index].nombre);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/" + Menu[index].foto, width: 100),
                          Text(Menu[index].nombre.toUpperCase()),
                        ],
                      ),
                    ));
              })),
    );
  }
}
