import 'package:flutter/material.dart';
import 'package:funcional_app/models/alumno.dart';
import 'package:funcional_app/models/profesor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:funcional_app/models/alumno.dart';

class ProfesorDetalle extends StatefulWidget {
  final id;
  final profesor;

  const ProfesorDetalle({super.key, required this.id, required this.profesor});

  @override
  State<ProfesorDetalle> createState() => _ProfesorDetalleState();
}

class _ProfesorDetalleState extends State<ProfesorDetalle> {
  final headers = {"context-type": "application/json;charset=UTF-8"};
  final nuevaPass = TextEditingController();

  final double coverHeight = 280;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    final p1 = widget.profesor; //contiene la información del usuario
    return Scaffold(
      appBar: AppBar(
        title: Text("MI PERFIL"), //titulo de la barra
      ),
      backgroundColor: Colors.blue[200],

      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          //header superior
          buildTop(),

          //Contenedor por cada dato del alumno

          //Nombre y apellidos
          Container(
            margin: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              //contiene el nombre y apellidos del usuario
              height: 70,
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  " ${p1.nombre} ${p1.apellidos}",
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),

          //Nickname
          Container(
            margin: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
                height: 70,
                margin: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Nickname:  ${p1.nombre_usuario} ",
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )),
          ),
          //Contraseña
          Container(
            margin: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
                height: 70,
                margin: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Contraseña:  ${p1.password} ",
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )),
          ),
          //Aula
        ],
      ),
      //boton flotante en el centro con lapiz
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          showFormAlum(p1);
        },
        elevation: 5,
        child: const Icon(Icons.edit),
      ),

      bottomNavigationBar: new BottomAppBar(
        child: Padding(
          //elimino el padding
          padding: const EdgeInsets.all(20),
        ),
        elevation: 0.0,
        color: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildCoverImage() => Container(
        height: 170,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/escolar2.png"),
            fit: BoxFit.cover,
          ),
          shape: BoxShape.rectangle,
        ),
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundImage: AssetImage("assets/ninio.png"),
      );

  Widget buildTop() {
    final top = 110;

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 100),
          child: buildCoverImage(),
        ),
        Positioned(top: 110, child: buildProfileImage()),
      ],
    );
  }

  //Meotod que enviara la nueva contraseña
  void cambiarPassword(Profesor t1) async {
    //var tarea = {"estado": "true", "usuario": t1.usuario.toString()};
    final url = "http://127.0.0.1:8000/profesores/${t1.idus}/";
    await http.put(Uri.parse(url),
        headers: {"content-type": "application/json;charset=UTF-8"},
        body: json.encode({"password": nuevaPass.text, "es_admin": true}));
    // ignore: use_build_context_synchronously
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("AVISO"),
            content: const Text(
                "Has cambiado la contraseña, tenlo en cuanta la proxima vez que incies sesion"),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "ACEPTAR",
                  style: TextStyle(color: Colors.pink),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void showFormAlum(Profesor alum) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Cambiar contraseña"),
            //Aqui vamos a poner el formulario
            content: Column(
              //Para que no ocupe todo el espacio disponible
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nuevaPass,
                  decoration:
                      const InputDecoration(hintText: "Nueva Contraseña"),
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancelar")),
              TextButton(
                  onPressed: () {
                    cambiarPassword(alum);
                    Navigator.of(context).pop();

                    setState(() {
                      //cambia el password de forma local
                      alum.password = nuevaPass.text;
                    });
                  },
                  child: const Text("Cambiar"))
            ],
          );
        });
  }
}
