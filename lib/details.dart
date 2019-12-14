import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'edit.dart';

class DetallesUsuario extends StatefulWidget {
  int index;
  List lista;

  DetallesUsuario({this.index, this.lista});

  @override
  _DetallesUsuarioState createState() => _DetallesUsuarioState();
}

class _DetallesUsuarioState extends State<DetallesUsuario> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("DETAILS"),
        backgroundColor: Colors.green,
      ),
      body: new Container(
        padding: EdgeInsets.all(10.0),
        child: new Center(
          child: Column(
            children: <Widget>[
              new Text(
                "ID: " + widget.lista[widget.index]['idUsuario'],
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              new Text(
                "Name: " + widget.lista[widget.index]['nombre'],
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              new Text(
                "Telephone: " + widget.lista[widget.index]['telefono'],
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              new Text(
                "Email: " + widget.lista[widget.index]['email'],
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              new RaisedButton(
                child: Text("EDIT"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context) => new EditarUsuario(
                        lista: widget.lista,
                        index: widget.index,
                      ),
                    ),
                  );
                },
              ),
              new RaisedButton(
                child: Text("DELETE"),
                onPressed: () {
                  var url = "http://192.168.172.2/pruebas/borrarUsuario.php";
                  http.post(url, body: {
                    "idUsuario": widget.lista[widget.index]['idUsuario']
                  });

                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
