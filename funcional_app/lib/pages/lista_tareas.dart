import 'package:flutter/material.dart';
import 'package:funcional_app/models/tareas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:funcional_app/pages/tarea_detalle.dart';

class ListaTareas extends StatefulWidget {
  const ListaTareas({super.key});

  @override
  State<ListaTareas> createState() => _ListaTareasState();
}

class _ListaTareasState extends State<ListaTareas> {
  //http://10.0.2.2:8000/tareas/
  //http://127.0.0.1:8000/tareas/
  final urlTareas = Uri.parse("http://127.0.0.1:8000/tareas/");

  final headers = {"content-type": "application/json;charset=UTF-8"};
  late Future<List<Tarea>> tareas;

  //controlador para el formulario
  final idta = TextEditingController();
  final nombre = TextEditingController();
  final descripcion = TextEditingController();
  final fecha_inicio = TextEditingController();
  final fecha_fin = TextEditingController();
  final estado = false;
  final usuario = TextEditingController();

  List<Tarea> lista_tareas = [];

  @override
  Widget build(BuildContext context) {
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

                      //lista_tareas.add(snap.data![i]);

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

                      // Mostramos el nombre de cada usuario
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
                                          builder: (context) => TareaDetallada(
                                            id: snap.data![i].idta,
                                            tarea: snap.data![i],
                                          ),
                                        )).then((_) {
                                      setState(() {
                                        tareas = getTareas();
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
                                                TareaDetallada(
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
          floatingActionButton: FloatingActionButton(
            //Cuando se presione
            onPressed: showFormAlum,
            child: const Icon(Icons.add),
          ),
        ));
  }

  //meetodo que llama al formulario de añadir un nuevo alumno
  void showFormAlum() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("AGREGAR TAREA"),
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
                  controller: descripcion,
                  decoration: const InputDecoration(hintText: "DESCRIPCIÓN"),
                ),
                TextField(
                  controller: fecha_inicio,
                  decoration: const InputDecoration(hintText: "FECHA INICIO"),
                ),
                TextField(
                  controller: fecha_fin,
                  decoration: const InputDecoration(hintText: "FECHA FIN"),
                ),
                TextField(
                  controller: usuario,
                  decoration: const InputDecoration(hintText: "USUARIO"),
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
                    saveTareas();
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
    tareas = getTareas();
  }

  /* Hace el get de alumnos el metodo que devolvera los alumnos*/
  Future<List<Tarea>> getTareas() async {
    /**Lo convertira en una Uri */
    final res = await http.get(urlTareas);
    final lista = List.from(jsonDecode(res.body));
    List<Tarea> tareas = [];
    lista.forEach((element) {
      final Tarea alumno = Tarea.fromJson(element);
      if ((alumno.estado == false)) {
        tareas.add(alumno);
      }
    });
    lista_tareas = tareas.reversed.toList();
    //Para que los ultimos creados aparezcan los primeros
    return tareas.reversed.toList();
  }

  //Hace el post de un nuevo alumno
  void saveTareas() async {
    /**Crea el objeto que se envia*/

    final tarea = {
      "nombre": nombre.text,
      "descripcion": descripcion.text,
      "fecha_inicio": fecha_inicio.text.substring(6) +
          '-' +
          fecha_inicio.text.substring(3, 5) +
          '-' +
          fecha_inicio.text.substring(0, 2),
      "fecha_fin": fecha_fin.text.substring(6) +
          '-' +
          fecha_fin.text.substring(3, 5) +
          '-' +
          fecha_fin.text.substring(0, 2),
      "estado": false,
      "usuario": usuario.text,
      "corregido": false,
    };

    print(tarea);

    await http.post(urlTareas, headers: headers, body: jsonEncode(tarea));
    nombre.clear();
    descripcion.clear();
    fecha_inicio.clear();
    fecha_fin.clear();
    idta.clear();
    usuario.clear;
    //para volver a actualizar los usuarios y que se actualice la interfaz
    setState(() {
      tareas = getTareas();
    });
  }
}
