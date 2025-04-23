class WarningModel {
  final String id;
  final String student;
  final String type;
  final String message;
  final Subjecta subject; // Reusing Subjecta from StudentAttendanceModel
  final Group group; // Reusing Group from StudentAttendanceModel
  final int absenceCount;
  final IssuedBy issuedBy;
  final String createdAt;
  final String updatedAt;
  final int version;

  WarningModel({
    required this.id,
    required this.student,
    required this.type,
    required this.message,
    required this.subject,
    required this.group,
    required this.absenceCount,
    required this.issuedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory WarningModel.fromJson(Map<String, dynamic> json) {
    return WarningModel(
      id: json['_id']?.toString() ?? '',
      student: json['student']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      subject: json['subject'] != null
          ? Subjecta.fromJson(json['subject'] as Map<String, dynamic>)
          : Subjecta(id: '', name: '', code: ''),
      group: json['group'] != null
          ? Group.fromJson(json['group'] as Map<String, dynamic>)
          : Group(id: '', name: ''),
      absenceCount: json['absenceCount'] is int ? json['absenceCount'] : 0,
      issuedBy: json['issued_by'] != null
          ? IssuedBy.fromJson(json['issued_by'] as Map<String, dynamic>)
          : IssuedBy(id: '', staffName: ''),
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      version: json['__v'] is int ? json['__v'] : 0,
    );
  }
}

class IssuedBy {
  final String id;
  final String staffName;

  IssuedBy({
    required this.id,
    required this.staffName,
  });

  factory IssuedBy.fromJson(Map<String, dynamic> json) {
    return IssuedBy(
      id: json['_id']?.toString() ?? '',
      staffName: json['staff_name']?.toString() ?? '',
    );
  }
}

// Reusing Subjecta and Group from your StudentAttendanceModel
class Subjecta {
  final String id;
  final String name;
  final String code;

  Subjecta({
    required this.id,
    required this.name,
    required this.code,
  });

  factory Subjecta.fromJson(Map<String, dynamic> json) {
    return Subjecta(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
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
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }
}
