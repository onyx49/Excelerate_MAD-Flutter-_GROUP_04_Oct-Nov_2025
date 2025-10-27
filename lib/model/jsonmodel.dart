import 'dart:io';

class Programlistingmodel {
  DateTime? startDate;
  String? title;
  String? description;
  int? students;
  int? lessons;
  int? completion;
  int? id;

  Programlistingmodel({
    this.startDate,
    this.title,
    this.description,
    this.students,
    this.lessons,
    this.completion,
    this.id,
  });

  Programlistingmodel.fromJson(Map<String, dynamic> json) {
    startDate = json['startDate'] != null
        ? DateTime.tryParse(json['startDate'].toString())
        : null;
    title = json['title']?.toString();
    description = json['description']?.toString();
    students = json['students'] is int
        ? json['students']
        : int.tryParse(json['students'].toString());
    lessons = json['lessons'] is int
        ? json['lessons']
        : int.tryParse(json['lessons'].toString());
    completion = json['completion'] is int
        ? json['completion']
        : int.tryParse(json['completion'].toString());
    id = json['id'] is int ? json['id'] : int.tryParse(json['id'].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate?.toIso8601String(),
      'title': title,
      'description': description,
      'students': students,
      'lessons': lessons,
      'completion': completion,
      'id': id,
    };
  }
}

class Userjsonmodel {
  int? id;
  String? email;
  String? role;

  Userjsonmodel({this.id, this.email, this.role});

  Userjsonmodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'role': role,
    };
  }
}
