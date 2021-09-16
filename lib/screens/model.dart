import 'dart:convert';

class Note {
  String title;
  String name;
  String designation;
  String department;
  String report;
  String number;
  Note({
    this.title,
    this.name,
    this.designation,
    this.department,
    this.report,
    this.number,
  });

  static fromJson(e) {}

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'name': name,
      'designation': designation,
      'department': department,
      'report': report,
      'number': number,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'],
      name: map['name'],
      designation: map['designation'],
      department: map['department'],
      report: map['report'],
      number: map['number'],
    );
  }

  String toJson() => json.encode(toMap());

}
