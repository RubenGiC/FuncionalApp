import 'package:flutter/material.dart';
import 'package:funcional_app/models/alumno.dart';
import 'package:funcional_app/models/tareas.dart';
import 'package:funcional_app/pages/tareas_corregir.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistorialTarea extends StatefulWidget {
  final id;
  const HistorialTarea({super.key, required this.id});

  @override
  State<HistorialTarea> createState() => _HistorialTareaState();
}

class _HistorialTareaState extends State<HistorialTarea> {
  //http://10.0.2.2:8000/tareas/
  //http://127.0.0.1:8000/tareas/
  final urlTareas = Uri.parse("http://127.0.0.1:8000/tareas/historial/");

  final headers = {"content-type": "application/json;charset=UTF-8"};
  late Future<List<Tarea>> tareas;
  //controlador para el formulario
  final idta = TextEditingController();
  final nombre = TextEditingController();
  final descripcion = TextEditingController();

  final estado = false;
  final usuario = TextEditingController();
  @override
  Widget build(BuildContext context) {
    late int comprobarid = widget.id;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de tareas'),
      ),
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
                  // Mostramos el nombre de cada usuario
                  return Column(
                    children: [
                      ListTile(
                          //Aqui vemos la imagen o lo que se one antes del texto
                          leading: Text(
                            snap.data![i].idta.toString(),
                            textScaleFactor: 4,
                          ),
                          //Aqui le pongo el borde y le ajusto los parametros
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side:
                                const BorderSide(width: 3, color: Colors.pink),
                          ),
                          title: Text(snap.data![i].nombre),
                          subtitle: Text(snap.data![i].descripcion),
                          //Aqui se pone lo que va despues del texto
                          trailing: IconButton(
                            icon: const Icon(Icons.arrow_forward_ios),
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      //Llama a tarea_detalle.dart para mostrar la informacion
                                      builder: (context) => TareaCorregir(
                                        id: snap.data![i].idta,
                                        tarea: snap.data![i],
                                      ),
                                    ));
                              });
                            },
                          )),
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
    );
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
      if (alumno.usuario == widget.id) {
        tareas.add(alumno);
      }
    });
    //Para que los ultimos creados aparezcan los primeros

    return tareas.reversed.toList();
  }
}
