import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:funcional_app/pages/perfil_usuario.dart';

class loginPicto extends StatefulWidget {
  @override
  _loginPictoState createState() => _loginPictoState();
}

class _loginPictoState extends State<loginPicto> {
  bool flag1 = true;
  bool flag2 = true;
  bool flag3 = true;
  bool flag4 = true;

  final String estrella = 'a';
  final String circulo = 'b';
  final String corazaon = 'c';
  final String triangulo = 'd';

  late String aux;
  final String contrasenia = 'abc';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          title: Text("IDENTIFICATE",
              style: TextStyle(color: Colors.black, fontSize: 20)),
          backgroundColor: Colors.white),
      backgroundColor: Colors.blue[200],
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.pinkAccent,
                blurRadius: 20.0,
                spreadRadius: 5.0,
                offset: Offset(7.0, 5.0))
          ],
        ),
        margin: EdgeInsets.only(
            top: 30, bottom: 30, left: 20, right: 20), //margen izq y dcha
        //padding: EdgeInsets.only(left: 20, right: 20, top: 20,),//pad de nombre y pass
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Flexible(
              child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => setState(() => flag1 = !flag1),
                      child: Image.asset(
                        "assets/estrella.png",
                        width: 200,
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(20),
                        backgroundColor:
                            flag1 ? Colors.pinkAccent[100] : Colors.white,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => flag2 = !flag2),
                      child: Image.asset(
                        "assets/circulo2.png",
                        width: 200,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            flag2 ? Colors.pinkAccent[100] : Colors.white,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => flag3 = !flag3),
                      child: Image.asset(
                        "assets/corazon2.png",
                        width: 200,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            flag3 ? Colors.pinkAccent[100] : Colors.white,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => (flag4 = !flag4)),
                      child: Image.asset(
                        "assets/triangulo.png",
                        width: 200,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            flag4 ? Colors.pinkAccent[100] : Colors.white,
                      ),
                    ),
                  ]),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: 500,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: ElevatedButton(
                  child: Text("INICIO SESION",
                      style: TextStyle(color: Colors.white, fontSize: 30)),
                  onPressed: () {
                    if (aux == contrasenia)
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => perfilAlumno()));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

/*

class Opciones extends StatelessWidget{
  Opciones({this.title="tt", this.icon=Icons.home, this.stylo:Colors.deepOrange});

  final String title;
  final IconData icon;
  final MaterialColor stylo;

  @override
  Widget build(BuildContext context){
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){},
        splashColor: Colors.pinkAccent[100],//al clickar en el boton
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget> [
                Icon(
                    icon,
                    size: 70.0,
                    color:  stylo,
                ),
                Text(title, style: new TextStyle(fontSize: 17.0) ),
              ],
            )
        ),
      ),
    );
  }
}
*/
/*
* class _loginPictoState extends State<loginPicto>{
  final List<bool> seleccion = List.generate(4,(_) => false);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: new AppBar(
          title: Text("IDENTIFICATE",
          style:TextStyle(color: Colors.black, fontSize: 20)),
          backgroundColor: Colors.white),

      backgroundColor: Colors.blue[200],

      body: Container(
        padding: EdgeInsets.all(20.0),
        child:GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            Opciones(title: "ESTRELLA",icon: Icons.star_sharp, stylo:Colors.amber,),
            Opciones(title: "CIRCULO",icon: Icons.circle, stylo:Colors.brown,),
            Opciones(title: "CORAZÓN",icon: Icons.favorite, stylo:Colors.red,),
            Opciones(title: "INFINITO",icon: Icons.all_inclusive_sharp, stylo:Colors.blue,),
          ],
        ),
      ),
    );
  }
}
*/
