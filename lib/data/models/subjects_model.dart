class SubjectsModel {
  final String message;
  final int page;
  final int totalPages;
  final int totalSubjects;
  final List<Subject> subjects;

  SubjectsModel({
    required this.message,
    required this.page,
    required this.totalPages,
    required this.totalSubjects,
    required this.subjects,
  });

  factory SubjectsModel.fromJson(Map<String, dynamic> json) {
    return SubjectsModel(
      message: json['message'],
      page: json['page'],
      totalPages: json['totalPages'],
      totalSubjects: json['totalSubjects'],
      subjects:
          List<Subject>.from(json['subjects'].map((x) => Subject.fromJson(x))),
    );
  }
}

class Subject {
  final String id;
  final String name;
  final String code;
  final String? department;
  final int year;
  final List<String> staff;
  final List<Group> groups;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final bool isDeleted;

  Subject({
    required this.id,
    required this.name,
    required this.code,
    this.department,
    required this.year,
    required this.staff,
    required this.groups,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isDeleted,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['_id'],
      name: json['name'],
      code: json['code'],
      department: json['department'],
      year: json['year'],
      staff: List<String>.from(json['staff'] ?? []),
      groups: List<Group>.from(
          (json['groups'] ?? []).map((x) => Group.fromJson(x))),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
      isDeleted: json['isDeleted'],
    );
  }
}

class Group {
  final String id;
  final String name;

  Group({
    required this.id,
    required this.name,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['_id'],
      name: json['name'],
    );
  }
}
