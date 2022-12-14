import 'package:flutter/material.dart';
import 'package:funcional_app/models/items.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListaItems extends StatefulWidget {
  const ListaItems({super.key});

  @override
  State<ListaItems> createState() => _ListaItemsState();
}

class _ListaItemsState extends State<ListaItems> {
  //url server
  final urlItems = Uri.parse("http://127.0.0.1:8000/item/");
  //cabecera
  final headers = {"content-type": "application/json;charset=UTF-8"};
  //lista de items
  late Future<List<Item>> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de articulos en stock'),
      ),
      body: FutureBuilder<List<Item>>(
        future: items,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: ((context, i) {
                return Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 250,
                      height: 70,
                      margin: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                      child: Text(
                        snapshot.data![i].nombre.toString(),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 50,
                      margin: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                      child: Text(
                        snapshot.data![i].stock.toString(),
                        textScaleFactor: 1.5,
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: const Icon(
                          Icons.add_circle,
                        ),
                        iconSize: 40,
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 20.0,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.remove_circle),
                        iconSize: 40,
                        onPressed: () {},
                      ),
                    ),
                  ],
                );
              }),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error interno 404."));
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }

  //metodo que se ejecuta cuando se inicia la app
  @override
  void initState() {
    super.initState();
    items = getItems();
  }

  //get que obtiene todos los items
  Future<List<Item>> getItems() async {
    //obtengo respuesta del server
    final res = await http.get(urlItems);

    //obtengo la lista json del body del server
    final lista = List.from(jsonDecode(res.body));

    //lista de todos los items
    List<Item> items = [];

    //recorre la lista json
    lista.forEach((element) {
      //convierto el json en un objeto Item
      final Item elem = Item.fromJson(element);
      items.add(elem); //lo añado a la lista de items
    });

    return items.reversed.toList();
  }
}
