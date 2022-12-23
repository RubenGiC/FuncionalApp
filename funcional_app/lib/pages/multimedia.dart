import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:funcional_app/models/pictogramas.dart';

class multimedia extends StatefulWidget {
  @override
  _multimediaState createState() => _multimediaState();
}

class _multimediaState extends State<multimedia> {
  bool flag1 = true;
  bool flag2 = true;
  bool flag3 = true;
  bool flag4 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("AYUDA MULTIMEDIA",
              style: TextStyle(color: Colors.black, fontSize: 20)),
          backgroundColor: Colors.white),
      backgroundColor: Colors.pinkAccent[100],
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: GridView.builder(
                  itemCount: Multimedia.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            //print("click en "+Menu[index].nombre);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => multimedia()));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Image.asset("assets/" + Multimedia[index].foto,
                                  width: 100),
                              Text(Multimedia[index].nombre),
                            ],
                          ),
                        ));
                  }),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 100),
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: ElevatedButton(
                  child: Text("VOLVER",
                      style: TextStyle(color: Colors.white, fontSize: 30)),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
