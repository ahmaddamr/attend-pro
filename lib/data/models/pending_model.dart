class PendingModel {
  final String message;
  final List<PendingStudentData> data;

  PendingModel({
    required this.message,
    required this.data,
  });

  factory PendingModel.fromJson(Map<String, dynamic> json) {
    return PendingModel(
      message: json['message'],
      data: List<PendingStudentData>.from(
        json['data'].map((e) => PendingStudentData.fromJson(e)),
      ),
    );
  }
}

class PendingStudentData {
  final String id;
  final Student student;
  final String subject;
  final String group;
  final String device;
  final String status;
  final String markedBy;
  final String checkInTime;
  final String sessionDate;
  final int weekNumber;
  final String sessionType;
  final String approved;
  final String createdAt;
  final String updatedAt;
  final String checkOutTime;

  PendingStudentData({
    required this.id,
    required this.student,
    required this.subject,
    required this.group,
    required this.device,
    required this.status,
    required this.markedBy,
    required this.checkInTime,
    required this.sessionDate,
    required this.weekNumber,
    required this.sessionType,
    required this.approved,
    required this.createdAt,
    required this.updatedAt,
    required this.checkOutTime,
  });

  factory PendingStudentData.fromJson(Map<String, dynamic> json) {
    return PendingStudentData(
      id: json['_id'],
      student: Student.fromJson(json['student']),
      subject: json['subject'],
      group: json['group'],
      device: json['device'],
      status: json['status'],
      markedBy: json['marked_by'],
      checkInTime: json['checkInTime'],
      sessionDate: json['sessionDate'],
      weekNumber: json['weekNumber'],
      sessionType: json['sessionType'],
      approved: json['approved'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      checkOutTime: json['checkOutTime'],
    );
  }
}

class Student {
  final String id;
  final User userId;
  final String studentName;
  final String department;
  final int year;
  final List<String> groups;
  final String createdAt;
  final String updatedAt;
  final int v;
  final String rfidTag;
  final String studentId;

  Student({
    required this.id,
    required this.userId,
    required this.studentName,
    required this.department,
    required this.year,
    required this.groups,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.rfidTag,
    required this.studentId,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['_id'],
      userId: User.fromJson(json['user_id']),
      studentName: json['student_name'],
      department: json['department'],
      year: json['year'],
      groups: List<String>.from(json['groups']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      rfidTag: json['rfid_tag'],
      studentId: json['student_id'],
    );
  }
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String universityEmail;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.universityEmail,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      universityEmail: json['university_email'],
    );
  }
}
