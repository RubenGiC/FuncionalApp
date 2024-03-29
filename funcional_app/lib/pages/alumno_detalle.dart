import 'package:flutter/material.dart';
import 'package:funcional_app/models/alumno.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:funcional_app/models/alumno.dart';

class AlumnoDetalle extends StatefulWidget {
  final id;
  final alumno;

  const AlumnoDetalle({super.key, required this.id, required this.alumno});

  @override
  State<AlumnoDetalle> createState() => _UsuarioDetalleState();
}

class _UsuarioDetalleState extends State<AlumnoDetalle> {
  final headers = {"context-type": "application/json;charset=UTF-8"};
  final nuevaPass = TextEditingController();

  final double coverHeight = 280;
  final double profileHeight = 144;
  late Alumno alum;

  @override
  Widget build(BuildContext context) {
    alum = widget.alumno; //contiene la información del usuario
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
                    "Id:  ${alum.idus} ",
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )),
          ),
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
                  " ${alum.nombre} ${alum.apellidos}",
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
                    "Nickname:  ${alum.nombre_usuario} ",
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
                    "Contraseña:  ${alum.password} ",
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )),
          ),
          //Aula
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
                    "Aula:  ${alum.aula} ",
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30.0, left: 500.0, right: 500.0),
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
                  alignment: Alignment.center,
                  child: Text(
                    "Para login pictogramas seguir la siguientes pautas:\n 'a para poner una estrella' ; 'b para un circulo'\n 'c para un corazon ; d para un triangulo'",
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )),
          ),
        ],
      ),
      //boton flotante en el centro con lapiz
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          showFormAlum(alum);
          alum.password = "hola";
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
        backgroundImage: AssetImage("assets/estudiante.png"),
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
  void cambiarPassword(Alumno t1) async {
    final url = "http://127.0.0.1:8000/alumnos/${t1.idus}/";
    await http.put(Uri.parse(url),
        headers: {"content-type": "application/json;charset=UTF-8"},
        body: json.encode({"password": nuevaPass.text}));

    //cambia el password de forma local
    alum.password = nuevaPass.text;
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

  void showFormAlum(Alumno alum) {
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
                  onPressed: () async {
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
