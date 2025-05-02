class SubjectsModel {
  final String status;
  final int results;
  final List<SubjectData> data;

  SubjectsModel({
    required this.status,
    required this.results,
    required this.data,
  });

  factory SubjectsModel.fromJson(Map<String, dynamic> json) {
    return SubjectsModel(
      status: json['status'] ?? '',
      results: json['results'] ?? 0,
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => SubjectData.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class SubjectData {
  final Subject subject;
  final Group group;
  final List<Instructor> instructors;
  final Schedule schedule;

  SubjectData({
    required this.subject,
    required this.group,
    required this.instructors,
    required this.schedule,
  });

  factory SubjectData.fromJson(Map<String, dynamic> json) {
    return SubjectData(
      subject: Subject.fromJson(json['subject'] ?? {}),
      group: Group.fromJson(json['group'] ?? {}),
      instructors: (json['instructors'] as List<dynamic>?)
              ?.map((e) => Instructor.fromJson(e))
              .toList() ??
          [],
      schedule: Schedule.fromJson(json['schedule'] ?? {}),
    );
  }
}

class Subject {
  final String id;
  final String name;
  final String code;
  final String department;
  final int year;

  Subject({
    required this.id,
    required this.name,
    required this.code,
    required this.department,
    required this.year,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      department: json['department'] ?? '',
      year: json['year'] ?? 0,
    );
  }
}

class Group {
  final String name;

  Group({required this.name});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      name: json['name'] ?? '',
    );
  }
}

class Instructor {
  final String id;
  final String name;
  final String role;

  Instructor({
    required this.id,
    required this.name,
    required this.role,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) {
    return Instructor(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
    );
  }
}

class Schedule {
  final String day;
  final String location;

  Schedule({
    required this.day,
    required this.location,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      day: json['day'] ?? '',
      location: json['location'] ?? '',
    );
  }
}
