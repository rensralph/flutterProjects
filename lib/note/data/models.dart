import 'dart:math';

class NotesModel {
  int id;
  String title;
  String content;
  bool isImportant;
  DateTime date;

  static const String ID = '_id';
  static const String TITLE = 'title';
  static const String CONTENT = 'content';
  static const String ISIMPORTANT = 'isImportant';
  static const String DATE = 'date';

  NotesModel({this.id, this.title, this.content, this.isImportant, this.date});

  NotesModel.fromMap(Map<String, dynamic> map) {
    this.id = map[ID];
    this.title = map[TITLE];
    this.content = map[CONTENT];
    this.isImportant = map[ISIMPORTANT] == 1 ? true : false;
    this.date = DateTime.parse(map[DATE]);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ID : this.id,
      TITLE : this.title,
      CONTENT : this.content,
      ISIMPORTANT : this.isImportant == true ? 1 : 0,
      DATE : this.date.toIso8601String()
    };
  }

  NotesModel.random() {
    this.id = Random(10).nextInt(1000) + 1;
    this.title = 'Lorem Ipsum ' * (Random().nextInt(4) + 1);
    this.content = 'Lorem Ipsum ' * (Random().nextInt(4) + 1);
    this.isImportant = Random().nextBool();
    this.date = DateTime.now().add(Duration(hours: Random().nextInt(100)));
  }
}
