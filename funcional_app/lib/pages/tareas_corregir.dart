//aqui cuando se pulse sobre una tarea se vendra aqui para detallarla

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:funcional_app/models/tareas.dart';
import 'package:http/http.dart' as http;

class TareaCorregir extends StatefulWidget {
  final int id;
  final Tarea tarea;
  const TareaCorregir({super.key, required this.id, required this.tarea});

  @override
  State<TareaCorregir> createState() => _TareaCorregirState();
}

class _TareaCorregirState extends State<TareaCorregir> {
  final headers = {"content-type": "application/json;charset=UTF-8"};
  @override
  Widget build(BuildContext context) {
    late Tarea t1 = widget.tarea;
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarea ${widget.id}"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          SizedBox(
            height: 50,
            child: Center(child: Text(t1.nombre)),
          ),

          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  child: const Center(
                      child: Text(
                    "Fecha Inicio",
                  )),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: const Text("Fecha Fin"),
                ),
              ],
            ),
          ),

          //contenedor fecha
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 10.0,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    t1.fecha_inicio.substring(8) +
                        '/' +
                        t1.fecha_inicio.substring(5, 7) +
                        '/' +
                        t1.fecha_inicio.substring(0, 4),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(
                      left: 20.0,
                    ),
                    width: 100,
                    child: Text(
                      t1.fecha_fin.substring(8) +
                          '/' +
                          t1.fecha_fin.substring(5, 7) +
                          '/' +
                          t1.fecha_fin.substring(0, 4),
                    )),
              ],
            ),
          ),

          //contenedor opciones de explicación
          Container(
            margin: const EdgeInsets.only(
              top: 20.0,
            ),
            child: Row(
              children: <Widget>[
                //para expandir por todo el width
                Expanded(
                  child: Container(
                    color: Color.fromARGB(255, 32, 231, 245),
                    width: 100,
                    height: 100,
                    child: IconButton(
                      icon: Icon(
                        Icons.play_circle,
                        size: 80,
                      ),
                      onPressed: () {
                        /*setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  //Llama a tarea_detalle.dart para mostrar la informacion
                                  builder: (context) => ListaTareas()));
                        });*/
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Color.fromARGB(255, 8, 156, 167),
                    width: 100,
                    height: 100,
                    child: IconButton(
                      icon: Icon(
                        Icons.list_alt,
                        size: 80,
                      ),
                      onPressed: () {
                        /*setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  //Llama a tarea_detalle.dart para mostrar la informacion
                                  builder: (context) => ListaTareas()));
                        });*/
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Color.fromARGB(255, 32, 231, 245),
                    width: 100,
                    height: 100,
                    child: IconButton(
                      icon: Icon(
                        Icons.voicemail,
                        size: 80,
                      ),
                      onPressed: () {
                        /*setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  //Llama a tarea_detalle.dart para mostrar la informacion
                                  builder: (context) => ListaTareas()));
                        });*/
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.green,
                    width: 100,
                    height: 100,
                    child: IconButton(
                      icon: Icon(
                        Icons.check,
                        size: 80,
                      ),
                      onPressed: () {
                        /*setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  //Llama a tarea_detalle.dart para mostrar la informacion
                                  builder: (context) => ListaTareas()));
                        });*/
                        corregirTarea(t1);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          //Contenedor descripción
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(
                    right: 20.0,
                    left: 20.0,
                  ),
                  child: const Center(child: Text('Descripcion:')),
                ),
                SizedBox(
                  child: Center(child: Text(t1.descripcion)),
                ),
              ],
            ),
          ),

          //Contenedor Estado
          Container(
            height: 20,
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(
                    right: 20.0,
                    left: 20.0,
                    bottom: 0.0,
                  ),
                  child: Text("¿Terminada?"),
                ),
                if (t1.estado) ...[
                  SizedBox(
                    child: Text("Si"),
                  ),
                ] else ...[
                  SizedBox(
                    child: Text("NO"),
                  ),
                ]
              ],
            ),
          ),

          //Contenedor descripción
          Container(
            height: 80,
            child: Row(
              children: <Widget>[
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(
                    right: 20.0,
                    left: 20.0,
                    top: 0.0,
                  ),
                  child: Text("usuario asignado:"),
                ),
                SizedBox(
                  height: 50,
                  child: Text(t1.usuario.toString()),
                ),
              ],
            ),
          ),

          //Boton para que vaya a editar
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                backgroundColor: Colors.pink,
                foregroundColor: Colors.black,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                )),
            child: const Text("Editar"),
          ),
        ],
      ),
    );
  }

  void corregirTarea(Tarea t1) async {
    final url = "http://127.0.0.1:8000/tareas/${t1.idta}/";
    await http.put(Uri.parse(url),
        headers: {"content-type": "application/json;charset=UTF-8"},
        body: json.encode({
          "estado": true,
          "corregido": true,
          "usuario": t1.usuario.toString()
        }));
    // ignore: use_build_context_synchronously
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Tarea corregida"),
            content: const Text("Falta introducir un texto"),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "ACEPTAR",
                  style: TextStyle(color: Colors.pink),
                ),
                onPressed: () {
                  getTarea(t1);
                  t1.corregido = true;
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void getTarea(Tarea t1) async {
    final url = "http://127.0.0.1:8000/tareas/${t1.idta}/";
    /**Lo convertira en una Uri */
    final res = await http.get(Uri.parse(url));
    var tarea = jsonDecode(res.body);

    final tareaFin = Tarea(
        idta: tarea["idta"],
        nombre: tarea["nombre"],
        descripcion: tarea["descripcion"],
        fecha_inicio: tarea["fecha_inicio"],
        fecha_fin: tarea["fecha_fin"],
        estado: tarea["estado"],
        usuario: tarea["usuario"],
        corregido: tarea["corregido"]);
    setState(() {
      tarea = tareaFin;
    });
    //Par que los ultimos creados aparezcan los primeros
  }
}
