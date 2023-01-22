import 'package:flutter/material.dart';
import 'package:funcional_app/models/tareas.dart';
import 'package:funcional_app/pages/tarea_detalle.dart';
import 'package:funcional_app/pages/tarea_detalle_usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/alumno.dart';

class ListaTareasUser extends StatefulWidget {
  final Alumno alumno;
  const ListaTareasUser({super.key, required this.alumno});

  @override
  State<ListaTareasUser> createState() => _ListaTareasUserState();
}

class _ListaTareasUserState extends State<ListaTareasUser> {
  //http://10.0.2.2:8000/tareas/
  //http://127.0.0.1:8000/tareas/
  final urlTareas = Uri.parse("http://127.0.0.1:8000/tareas/");

  final headers = {"content-type": "application/json;charset=UTF-8"};
  late Future<List<Tarea>> tareas;
  List<Tarea> lista_tareas = [];
  //controlador para el formulario
  final idta = TextEditingController();
  final nombre = TextEditingController();
  final descripcion = TextEditingController();
  final fecha_inicio = TextEditingController();
  final fecha_fin = TextEditingController();
  final estado = false;
  final usuario = TextEditingController();
  @override
  Widget build(BuildContext context) {
    late Alumno a1 = widget.alumno;
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Escolar',
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("LISTA DE TAREAS"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          backgroundColor: Colors.blue[200],
          body: FutureBuilder<List<Tarea>>(
            future: tareas,
            builder: (context, snap) {
              //Comprobamos si se han cargado los datos,
              //si se han cargado se muestra la lista de usuarios
              if (snap.hasData) {
                return ListView.builder(

                    //Con el simbolo de exclamacion se dice que estamos seguro que no va a ser nulo
                    itemCount: snap.data!.length,
                    itemBuilder: (context, i) {
                      var icono = Icons.task;

                      //dependiendo de las palabras clave cambiara el icono
                      if (lista_tareas[i]
                          .nombre
                          .toLowerCase()
                          .contains('menu')) {
                        icono = Icons.menu_book;
                      } else if (lista_tareas[i]
                          .nombre
                          .toLowerCase()
                          .contains('ventanas')) {
                        icono = Icons.window;
                      }

                      // Mostramos las tareas
                      return Column(
                        children: [
                          Material(
                            elevation: 4.0,
                            borderRadius: BorderRadius.circular(5.0),
                            color: Color.fromARGB(255, 248, 246, 246),
                            child: ListTile(
                                //Aqui vemos la imagen o lo que se one antes del texto
                                leading: Icon(icono),
                                //Aqui le pongo el borde y le ajusto los parametros
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: const BorderSide(
                                      width: 3, color: Colors.pink),
                                ),
                                title:
                                    Text(lista_tareas[i].nombre.toUpperCase()),
                                subtitle: Text(
                                    lista_tareas[i].descripcion.toUpperCase()),
                                //Aqui se pone lo que va despues del texto
                                trailing: IconButton(
                                  icon: const Icon(Icons.arrow_forward_ios),
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          //Llama a tarea_detalle.dart para mostrar la informacion
                                          builder: (context) =>
                                              TareaDetalladaUsuario(
                                            id: lista_tareas[i].idta,
                                            tarea: lista_tareas[i],
                                          ),
                                        )).then((_) {
                                      setState(() {
                                        tareas = getTareas(a1);
                                      });
                                    });
                                  },
                                  /*onPressed: () {
                                    setState(() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            //Llama a tarea_detalle.dart para mostrar la informacion
                                            builder: (context) =>
                                                TareaDetalladaUsuario(
                                              id: snap.data![i].idta,
                                              tarea: snap.data![i],
                                            ),
                                          ));
                                    });
                                  },*/
                                )),
                          )
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
          //Vamos a crear un boton para añadir nuevos usuarios
        ));
  }

  //meetodo que llama al formulario de añadir un nuevo alumno

  /// Este metodo se eejcuta cuando la aplicacion inicie
  @override
  void initState() {
    super.initState();
    tareas = getTareas(widget.alumno);
  }

  /* Hace el get de alumnos el metodo que devolvera los alumnos*/
  Future<List<Tarea>> getTareas(Alumno a1) async {
    /**Lo convertira en una Uri */
    final res = await http.get(urlTareas);
    final lista = List.from(jsonDecode(res.body));
    List<Tarea> tareas = [];
    lista.forEach((element) {
      final Tarea alumno = Tarea.fromJson(element);
      if ((alumno.estado == false) && (alumno.usuario == a1.idus)) {
        tareas.add(alumno);
      }
    });

    lista_tareas = tareas.reversed.toList();

    //Para que los ultimos creados aparezcan los primeros
    return tareas.reversed.toList();
  }

  //Hace el post de un nuevo alumno
}
