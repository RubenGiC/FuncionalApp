import 'package:flutter/material.dart';
import 'package:funcional_app/main.dart';
import 'package:funcional_app/models/tareas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EdicionTarea extends StatefulWidget {
  final Tarea tarea;
  final int id;

  const EdicionTarea({super.key, required this.id, required this.tarea});

  @override
  State<EdicionTarea> createState() => _EdicionTarea();
}

class _EdicionTarea extends State<EdicionTarea> {
  final headers = {"content-type": "application/json;charset=UTF-8"};

  @override
  Widget build(BuildContext context) {
    late Tarea task = widget.tarea;
    var et_titulo = TextEditingController();
    var et_fini = TextEditingController();
    var et_ffin = TextEditingController();
    var et_descrip = TextEditingController();
    bool estado = task.estado;
    var et_usuario = TextEditingController();

    et_titulo.text = task.nombre;
    et_fini.text = task.fecha_inicio;
    et_ffin.text = task.fecha_fin;
    et_descrip.text = task.descripcion;

    TextEditingController dateCtl = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("EDICIÓN DE TAREA: ${widget.tarea.nombre}".toUpperCase()),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: et_titulo,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'TITULO',
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10),
            ),
            //para el calendario de fecha inicio
            Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: et_fini, //editing controller of this TextField
                  decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "FECHA DE INICIO" //label text of field
                      ),
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime(
                            int.parse(et_fini.text.substring(0, 4)),
                            int.parse(et_fini.text.substring(5, 7)),
                            int.parse(et_fini.text.substring(8))),
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      //String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      //print(formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      et_fini.text =
                          "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}"; //set output date to TextField value.

                    } else {
                      print("Date is not selected");
                    }
                  },
                )),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10),
            ),
            //para el calendario de fecha fin
            Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: et_ffin, //editing controller of this TextField
                  decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "FECHA DE FIN" //label text of field
                      ),
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime(
                            int.parse(et_ffin.text.substring(0, 4)),
                            int.parse(et_ffin.text.substring(5, 7)),
                            int.parse(et_ffin.text.substring(8))),
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      //String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      //print(formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      et_ffin.text =
                          "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}"; //set output date to TextField value.

                    } else {
                      print("Date is not selected");
                    }
                  },
                )),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10),
            ),
            //descripción
            Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: et_descrip,
                  keyboardType: TextInputType.multiline,
                  minLines: 1, //Normal textInputField will be displayed
                  maxLines: 5, // when user presses enter it will adapt to it
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'DESCRIPCIÓN',
                  ),
                ))
              ],
            ),
            /*Row(
              children: [
                Text("¿TERMINADA?"),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: MyStatefulWidget(
                    estado: estado,
                  ),
                ),
                Container(
                  child: Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: estado,
                    onChanged: (bool? value) {
                      setState(() {
                        estado = value!;
                      });
                    },
                  ),
                ),
              ],
            ),*/

            /*CheckboxListTile(
              value: estado,
              onChanged: (bool? value) {
                setState(() {
                  if (estado) {
                    estado = false;
                  } else {
                    estado = true;
                  }
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Animate Slowly'),
              value: estado,
              onChanged: (bool? value) {
                setState(() {
                  if (estado) {
                    estado = false;
                  } else {
                    estado = true;
                  }
                });
              },
            ),*/

            //Boton para que vaya a editar
            TextButton(
              onPressed: () {
                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      //Llama a tarea_detalle.dart para mostrar la informacion
                      builder: (context) => MyApp(),
                    ));*/
              },
              style: TextButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.black,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  )),
              child: const Text("EDITAR"),
            ),
          ],
        ),
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
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

class MyStatefulWidget extends StatefulWidget {
  final bool estado;
  const MyStatefulWidget({super.key, required this.estado});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
