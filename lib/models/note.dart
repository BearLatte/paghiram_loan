class Note {
  String id;
  String year;
  String date;
  String title;
  String content;

  Note({ required this.id, required this.year, required this.date, required this.title, required this.content});

  Note.fromJson(dynamic json)
      : id = json['id'],
        year = json['year'],
        date = json['date'],
        title = json['title'],
        content = json['content'];

  Map toJson() {
    Map map = {};
    map['id'] = id;
    map['year'] = year;
    map['date'] = date;
    map['title'] = title;
    map['content'] = content;
    return map;
  }
}
