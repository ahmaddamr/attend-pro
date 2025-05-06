class StaffSubjectsModel {
  final String status;
  final int results;
  final List<StaffSubjectData> data;

  StaffSubjectsModel({
    required this.status,
    required this.results,
    required this.data,
  });

  factory StaffSubjectsModel.fromJson(Map<String, dynamic> json) {
    return StaffSubjectsModel(
      status: json['status'],
      results: json['results'],
      data: List<StaffSubjectData>.from(
        json['data'].map((e) => StaffSubjectData.fromJson(e)),
      ),
    );
  }
}

class StaffSubjectData {
  final Subject subject;
  final Group group;
  final String role;
  final Schedule? schedule;

  StaffSubjectData({
    required this.subject,
    required this.group,
    required this.role,
    this.schedule,
  });

  factory StaffSubjectData.fromJson(Map<String, dynamic> json) {
    return StaffSubjectData(
      subject: Subject.fromJson(json['subject']),
      group: Group.fromJson(json['group']),
      role: json['role'],
      schedule:
          json['schedule'] != null ? Schedule.fromJson(json['schedule']) : null,
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
      id: json['id'],
      name: json['name'],
      code: json['code'],
      department: json['department'],
      year: json['year'],
    );
  }
}

class Group {
  final String name;

  Group({required this.name});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(name: json['name']);
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
      day: json['day'],
      location: json['location'],
    );
  }
}
