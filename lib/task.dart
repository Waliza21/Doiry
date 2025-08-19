class Task{
  final String id;
  String text;
  bool isDone;

  Task({required this.id,required this.text,required this.isDone});

  factory Task.fromJson(Map<String,dynamic> json){
    return Task(id: json['_id'],
    text: json['text'],
    isDone: json['isDone'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'text':text,
      'isDone':isDone,
    };
  }
}