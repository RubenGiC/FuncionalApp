import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:funcional_app/models/alumno.dart';
import 'package:funcional_app/pages/usuario_detalle.dart';

import 'package:http/http.dart' as http;

class ListaUsuarios extends StatefulWidget {
  const ListaUsuarios({super.key});

  @override
  State<ListaUsuarios> createState() => _ListaUsuariosState();
}

class _ListaUsuariosState extends State<ListaUsuarios> {
  /**Donde queremos acceder */
  /// Se cambia el 127.0.0.1 por 10.0.2.2:8000//
  /// http://127.0.0.1:8000/alumnos/
  /// http://10.0.2.2:8000/alumnos/
  final urlAlumnos = Uri.parse("http://127.0.0.1:8000/alumnos/");
  //Cabecera que llevaran las peticiones JSOn
  final headers = {"content-type": "application/json;charset=UTF-8"};
  late Future<List<Alumno>> alumnos;
  //controlador para el formulario
  final idus = TextEditingController();
  final nombre = TextEditingController();
  final apellidos = TextEditingController();
  final nombre_usuario = TextEditingController();
  final password = TextEditingController();
  final aula = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuarios'),
      ),
      body: FutureBuilder<List<Alumno>>(
        future: alumnos,
        builder: (context, snap) {
          //Comprobamos si se han cargado los datos,
          //si se han cargado se muestra la lista de usuarios
          if (snap.hasData) {
            return ListView.builder(
                //Con el simbolo de exclamacion se dice que estamos seguro que no va a ser nulo
                itemCount: snap.data!.length,
                itemBuilder: (context, i) {
                  // Mostramos el nombre de cada usuario
                  return Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.face_rounded,
                            size: 40.0, color: Colors.blue),
                        title: Text(snap.data![i].nombre),
                        subtitle: Text(snap.data![i].apellidos),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UsuarioDetalle(
                                    id: snap.data![i].idus,
                                    usuario: snap.data![i],
                                  ),
                                ),
                              );
                            });
                          },
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                      //Pone una linea entre cada uno
                      const Divider()
                    ],
                  );
                });
          }
          if (snap.hasError) {
            return const Center(child: Text("Hay un error"));
          }
          return const CircularProgressIndicator();
        },
      ),
      //Vamos a crear un botono para añadir nuevos usuarios
      floatingActionButton: FloatingActionButton(
        //Cuando se presione
        onPressed: showFormAlum,
        child: const Icon(Icons.add),
      ),
    );
  }

  //meetodo que llama al formulario de añadir un nuevo alumno
  void showFormAlum() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Agregar Alumno"),
            //Aqui vamos a poner el formulario
            content: Column(
              //Para que no ocupe todo el espacio disponible
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nombre,
                  decoration: const InputDecoration(hintText: "NOMBRE"),
                ),
                TextField(
                  controller: apellidos,
                  decoration: const InputDecoration(hintText: "APELLIDOS"),
                ),
                TextField(
                  controller: nombre_usuario,
                  decoration: const InputDecoration(hintText: "NOMBRE USUARIO"),
                ),
                TextField(
                  controller: password,
                  decoration: const InputDecoration(hintText: "CONTRASEÑA"),
                ),
                TextField(
                  controller: aula,
                  decoration: const InputDecoration(hintText: "AULA"),
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
                    saveAlumnos();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Guardar"))
            ],
          );
        });
  }

  /// Este metodo se eejcuta cuando la aplicacion inicie
  @override
  void initState() {
    super.initState();
    alumnos = getAlumnos();
  }

  /* Hace el get de alumnos el metodo que devolvera los alumnos*/
  Future<List<Alumno>> getAlumnos() async {
    /**Lo convertira en una Uri */
    final res = await http.get(urlAlumnos);
    final lista = List.from(jsonDecode(res.body));
    List<Alumno> alumnos = [];
    lista.forEach((element) {
      final Alumno alumno = Alumno.fromJson(element);
      alumnos.add(alumno);
    });
    //Para que los ultimos creados aparezcan los primeros
    return alumnos.reversed.toList();
  }

  //Hace el post de un nuevo alumno
  void saveAlumnos() async {
    /**Crea el objeto que se envia*/
    final user = {
      "idus": idus.text,
      "nombre": nombre.text,
      "apellidos": apellidos.text,
      "nombre_usuario": nombre_usuario.text,
      "password": password.text,
      "aula": aula.text
    };
    await http.post(urlAlumnos, headers: headers, body: jsonEncode(user));
    nombre.clear();
    apellidos.clear();
    nombre_usuario.clear();
    password.clear();
    aula.clear();
    idus.clear();
    //para volver a actualizar los usuarios y que se actualice la interfaz
    setState(() {
      alumnos = getAlumnos();
    });
  }
}
