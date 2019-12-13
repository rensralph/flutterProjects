import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String id;
  final db = Firestore.instance;

  TextEditingController todo = TextEditingController();
  ScrollController _sc = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Demo"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Task',
                        fillColor: Colors.grey[300],
                        filled: true,
                      ),
                      // 
                      controller: todo,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: createData,
                    child: Text("Submit"),
                  )
                ],
              ),
              Container(
                child: ListView(
                  controller: _sc,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(8.0),
                  children: <Widget>[
                    //StreamBuilder
                    //QuertSnapshot
                    StreamBuilder<QuerySnapshot>(
                      ///stream
                      stream: db.collection('test').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                              children: snapshot.data.documents
                                  .map((doc) => buildItem(doc))
                                  .toList());
                        } else {
                          return SizedBox();
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  

  void createData() async {
    final task = todo.text;
    //DateFormat converts Datetime(timestamp) into date and time
    var now = new DateTime.now();
    DocumentReference ref = await db.collection('test').add({
      'todo': '$task', 
      'td': DateFormat("yyyy-MM-dd hh:mm:ss").format(now)});
      
    setState(() => id = ref.documentID);
    print(ref.documentID);
  }

  void updateData(DocumentSnapshot doc) async {
    final task = todo.text;
    var now = new DateTime.now();
    await db
        .collection('test')
        .document(doc.documentID)
        .updateData({
          'todo': '$task', 
          'td': DateFormat("yyyy-MM-dd hh:mm:ss").format(now)});
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('test').document(doc.documentID).delete();
    setState(() => id = null);
  }

  Card buildItem(DocumentSnapshot doc) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'todo: ${doc.data['todo']}',
              style: TextStyle(fontSize: 24),
            ),Text(
              'td: ${doc.data['td']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () => updateData(doc),
                  child: Text('Update todo',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.green,
                ),
                SizedBox(width: 8),
                FlatButton(
                  onPressed: () => deleteData(doc),
                  child: Text('Delete'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}