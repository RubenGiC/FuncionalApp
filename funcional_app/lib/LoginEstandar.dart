import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:funcional_app/main.dart';
import 'package:funcional_app/main.dart';
import 'package:funcional_app/pages/perfil_admin.dart';
import 'package:funcional_app/principal.dart';
import 'package:funcional_app/pages/perfil_usuario.dart';
import 'package:http/http.dart' as http;

import 'models/alumno.dart';
import 'models/profesor.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController usuario = new TextEditingController();
  TextEditingController contrasena = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.pink,
                blurRadius: 30.0,
                spreadRadius: 5.0,
                offset: Offset(10.0, 10.0))
          ],
        ),
        margin: EdgeInsets.only(
            top: 70, bottom: 70, left: 50, right: 50), //margen izq y dcha
        padding: EdgeInsets.only(left: 20, right: 20), //pad de nombre y pass
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .center, //alineamos en el centro de la pantalla
            children: [
              Image.asset(
                "assets/logosolo.png",
                height: 150,
              ),
              TextField(
                controller: usuario,
                decoration:
                    InputDecoration(hintText: "Nombre usuario".toUpperCase()),
              ),
              SizedBox(
                height: 20,
              ), //separacion entre usr y pass
              TextField(
                controller: contrasena,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Contrasena".toUpperCase(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                    child: Text("Inicio Sesion".toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    onPressed: () {
                      getAlumnos();
                    }),
              ),
              //SizedBox(height: 100,),
              //Text("Nuevo usuario? crear cuenta")
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Alumno>> getAlumnos() async {
    /**Lo convertira en una Uri */
    final res = await http.get(Uri.parse("http://127.0.0.1:8000/alumnos/"));
    final lista = List.from(jsonDecode(res.body));
    var encontrado = false;
    List<Alumno> usuarios = [];
    lista.forEach((element) {
      final Alumno alumno = Alumno.fromJson(element);
      usuarios.add(alumno);
      if ((usuario.text == alumno.nombre_usuario) &&
          (contrasena.text == alumno.password)) {
        encontrado = true;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => PerfilAlumno(
                      alumno: alumno,
                    )));
      } else {
        encontrado = false;
      }
    });
    //Aqui busca si es profesor, este if es para que no busque si a encontrado un alumno
    if (!encontrado) {
      final res2 =
          await http.get(Uri.parse("http://127.0.0.1:8000/profesores/"));
      final lista2 = List.from(jsonDecode(res2.body));
      lista2.forEach((element) {
        final Profesor profe = Profesor.fromJson(element);

        if ((usuario.text == profe.nombre_usuario) &&
            (contrasena.text == profe.password)) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => perfilAdmin(
                        profe: profe,
                      )));
        }
      });
    }

    //Para que los ultimos creados aparezcan los primeros
    return usuarios.reversed.toList();
  }
}
