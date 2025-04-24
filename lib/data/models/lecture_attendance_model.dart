class LectureAttendanceModel {
  final String message;
  final AttendanceDatas data;

  LectureAttendanceModel({
    required this.message,
    required this.data,
  });

  factory LectureAttendanceModel.fromJson(Map<String, dynamic> json) {
    return LectureAttendanceModel(
      message: json['message'] ?? '',
      data: AttendanceDatas.fromJson(json['data'] ?? {}),
    );
  }
}

class AttendanceDatas {
  final List<AttendanceRecord> attended;
  final List<AttendanceRecord> pending;

  AttendanceDatas({
    required this.attended,
    required this.pending,
  });

  factory AttendanceDatas.fromJson(Map<String, dynamic> json) {
    return AttendanceDatas(
      attended: (json['attended'] as List<dynamic>?)
              ?.map((e) => AttendanceRecord.fromJson(e))
              .toList() ??
          [],
      pending: (json['pending'] as List<dynamic>?)
              ?.map((e) => AttendanceRecord.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class AttendanceRecord {
  final String id;
  final Student student;
  final String subject;
  final String group;
  final String device;
  final String status;
  final String markedBy;
  final String checkInTime;
  final String checkOutTime;
  final String sessionDate;
  final int weekNumber;
  final String sessionType;
  final String approved;
  final String createdAt;
  final String updatedAt;

  AttendanceRecord({
    required this.id,
    required this.student,
    required this.subject,
    required this.group,
    required this.device,
    required this.status,
    required this.markedBy,
    required this.checkInTime,
    required this.checkOutTime,
    required this.sessionDate,
    required this.weekNumber,
    required this.sessionType,
    required this.approved,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      id: json['_id'] ?? '',
      student: Student.fromJson(json['student'] ?? {}),
      subject: json['subject'] ?? '',
      group: json['group'] ?? '',
      device: json['device'] ?? '',
      status: json['status'] ?? '',
      markedBy: json['marked_by'] ?? '',
      checkInTime: json['checkInTime'] ?? '',
      checkOutTime: json['checkOutTime'] ?? '',
      sessionDate: json['sessionDate'] ?? '',
      weekNumber: json['weekNumber'] ?? 0,
      sessionType: json['sessionType'] ?? '',
      approved: json['approved'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class Student {
  final String id;
  final User user;
  final String studentName;
  final String studentId;
  final String? department;
  final List<String> groups;
  final int year;
  final String rfidTag;
  final String createdAt;
  final String updatedAt;

  Student({
    required this.id,
    required this.user,
    required this.studentName,
    required this.studentId,
    this.department,
    required this.groups,
    required this.year,
    required this.rfidTag,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['_id'] ?? '',
      user: User.fromJson(json['user_id'] ?? {}),
      studentName: json['student_name'] ?? '',
      studentId: json['student_id'] ?? '',
      department: json['department'],
      groups: List<String>.from(json['groups'] ?? []),
      year: json['year'] ?? 0,
      rfidTag: json['rfid_tag'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String universityEmail;
  final String role;
  final String phoneNumber;
  final bool isVerified;
  final String otp;
  final String expiresIn;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.universityEmail,
    required this.role,
    required this.phoneNumber,
    required this.isVerified,
    required this.otp,
    required this.expiresIn,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      universityEmail: json['university_email'] ?? '',
      role: json['role'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      isVerified: json['isVerified'] ?? false,
      otp: json['OTP'] ?? '',
      expiresIn: json['expiresIn'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
