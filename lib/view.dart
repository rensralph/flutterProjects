import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class AgregarUsuario extends StatefulWidget {
  @override
  _AgregarUsuarioState createState() => _AgregarUsuarioState();
}

class _AgregarUsuarioState extends State<AgregarUsuario> {
  TextEditingController controlNombre = new TextEditingController();
  TextEditingController controlTelefono = new TextEditingController();
  TextEditingController controlEmail = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("LIST"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Container(
          padding: EdgeInsets.all(50.0),
          child: new Center(
            child: new Column(
              children: <Widget>[
                new TextField(
                  controller: controlNombre,
                  decoration: new InputDecoration(labelText: "Name"),
                ),
                new TextField(
                  controller: controlTelefono,
                  decoration: new InputDecoration(labelText: "Telephone"),
                ),
                new TextField(
                  controller: controlEmail,
                  decoration: new InputDecoration(labelText: "Email"),
                ),
                new RaisedButton(
                  child: new Text("Submit"),
                  onPressed: () {
                    agregarUsuario();
                    Navigator.of(context).pop();
                  },
                  color: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void agregarUsuario() {
    var url = "http://192.168.172.2/pruebas/agregarUsuario.php";
    http.post(url, body: {
      "nombre": controlNombre.text,
      "telefono": controlTelefono.text,
      "email": controlEmail.text,
    });
  }
}
