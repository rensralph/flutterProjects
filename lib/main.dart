import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';
import 'view.dart';
import 'details.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new UserList(),
    );
  }
}

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  Future<List> getUsers() async {
    final response =
        await http.get("http://192.168.172.2/pruebas/getUsers.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("LIST"),
        backgroundColor: Colors.green,
      ),
      body: new FutureBuilder<List>(
        future: getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ElementoLista(
                  lista: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
      floatingActionButton: new FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new AgregarUsuario(),
        )),
      ),
    );
  }
}

class ElementoLista extends StatelessWidget {
  final List lista;

  ElementoLista({this.lista});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: lista == null ? 0 : lista.length,
      itemBuilder: (context, posicion) {
        return new Container(
          padding: EdgeInsets.all(2.0),
          child: new GestureDetector(
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new DetallesUsuario(
                  index: posicion,
                  lista: lista,
                ),
              ));
            },
            child: new Card(
              color: Colors.deepOrangeAccent,
              child: new Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  lista[posicion]['idUsuario'] +
                      ": " +
                      lista[posicion]['nombre'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
