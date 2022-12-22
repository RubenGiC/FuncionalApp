import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:funcional_app/pages/lista_tareas.dart';
import 'package:funcional_app/pages/lista_items.dart';
import 'package:funcional_app/pages/lista_usuarios.dart';

class perfilAdmin extends StatefulWidget {
  @override
  _perfilAdminState createState() => _perfilAdminState();
}

class _perfilAdminState extends State<perfilAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("          INICIO",
            style: TextStyle(
              fontSize: 30,
            )),
      ),
      backgroundColor: Colors.blue[200],
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: new Text(
                "Ruben ",
                style: new TextStyle(fontSize: 28),
              ),
              accountEmail: new Text("Ruben1323@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/estudiante.png"),
              ),
              decoration: new BoxDecoration(
                color: Colors.pink[100],
                image: const DecorationImage(
                  image: AssetImage("assets/fondo.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("MI PERFIL", style: new TextStyle(fontSize: 20)),
              onTap: () {
                // change app state...
                Navigator.pop(context); // close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications_active_rounded),
              title: Text("NOTIFICACIONES", style: new TextStyle(fontSize: 20)),
            ),
            ListTile(
              leading: Icon(Icons.settings_applications_outlined),
              title: Text("AJUSTES", style: new TextStyle(fontSize: 20)),
            ),
            ListTile(
              leading: Icon(
                Icons.outbond_outlined,
                color: Colors.red,
              ),
              title: Text("SALIR", style: new TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Opciones(
              title: "Mi perfil",
              icon: Icons.perm_identity,
              stylo: Colors.red,
              tipo: 0,
            ),
            Opciones(
              title: "Lista de Tareas",
              icon: Icons.library_books_sharp,
              stylo: Colors.orange,
              tipo: 1,
            ),
            Opciones(
              title: "Tareas Realizadas",
              icon: Icons.check_circle,
              stylo: Colors.green,
              tipo: 2,
            ),
            Opciones(
              title: "Inventario",
              icon: Icons.border_color_rounded,
              stylo: Colors.brown,
              tipo: 3,
            ),
            Opciones(
              title: "Lista de Usuarios",
              icon: Icons.notifications_active_rounded,
              stylo: Colors.red,
              tipo: 4,
            ),
            Opciones(
              title: "Chat",
              icon: Icons.textsms,
              stylo: Colors.blue,
              tipo: 5,
            ),
            Opciones(
              title: "Menu",
              icon: Icons.flatware,
              stylo: Colors.orange,
              tipo: 6,
            ),
          ],
        ),
      ),
    );
  }
}

class Opciones extends StatelessWidget {
  Opciones({
    this.title = "tt",
    this.icon = Icons.home,
    this.stylo: Colors.deepOrange,
    this.tipo = 0,
  });

  final String title;
  final IconData icon;
  final MaterialColor stylo;
  final int tipo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          switch (tipo) {
            case 1:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    //Llama a tarea_detalle.dart para mostrar la informacion
                    builder: (context) => ListaTareas(),
                  ));
              break;
            case 3:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    //Llama a tarea_detalle.dart para mostrar la informacion
                    builder: (context) => ListaItems(),
                  ));
              break;
            case 4:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    //Llama a tarea_detalle.dart para mostrar la informacion
                    builder: (context) => ListaUsuarios(),
                  ));
              break;
          }
        },
        splashColor: Colors.pinkAccent[100], //al clickar en el boton
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Icon(
              icon,
              size: 70.0,
              color: stylo,
            ),
            Text(title, style: new TextStyle(fontSize: 30.0))
          ],
        )),
      ),
    );
  }
}
