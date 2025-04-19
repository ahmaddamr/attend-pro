class CoursesModel {
  final bool success;
  final int total;
  final String staffId;
  final List<CourseSubject> subjects;

  CoursesModel({
    required this.success,
    required this.total,
    required this.staffId,
    required this.subjects,
  });

  factory CoursesModel.fromJson(Map<String, dynamic> json) {
    return CoursesModel(
      success: json['success'],
      total: json['total'],
      staffId: json['staff_id'],
      subjects: List<CourseSubject>.from(
        json['subjects'].map((x) => CourseSubject.fromJson(x)),
      ),
    );
  }
}

class CourseSubject {
  final String id;
  final String name;
  final String code;
  final Department department;
  final int year;

  CourseSubject({
    required this.id,
    required this.name,
    required this.code,
    required this.department,
    required this.year,
  });

  factory CourseSubject.fromJson(Map<String, dynamic> json) {
    return CourseSubject(
      id: json['_id'],
      name: json['name'],
      code: json['code'],
      department: Department.fromJson(json['department']),
      year: json['year'],
    );
  }
}

class Department {
  final String id;
  final String name;

  Department({
    required this.id,
    required this.name,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['_id'],
      name: json['name'],
    );
  }
}
