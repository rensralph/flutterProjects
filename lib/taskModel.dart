class Tasks{
  int id;
  String tasks;

  Tasks({this.id, this.tasks});

  factory Tasks.fromJson(Map<String, dynamic> json){
    return new Tasks(
      id: json['_id'],
      tasks: json['tasks']
    );
  }
}