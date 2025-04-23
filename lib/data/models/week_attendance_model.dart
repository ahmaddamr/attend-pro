class GroupAttendanceModel {
  final String message;
  final List<WeekAttendance> data;

  GroupAttendanceModel({required this.message, required this.data});

  factory GroupAttendanceModel.fromJson(Map<String, dynamic> json) {
    return GroupAttendanceModel(
      message: json['message'],
      data: List<WeekAttendance>.from(
          json['data'].map((x) => WeekAttendance.fromJson(x))),
    );
  }
}

class WeekAttendance {
  final int weekNumber;
  final List<AttendanceRecord> records;

  WeekAttendance({required this.weekNumber, required this.records});

  factory WeekAttendance.fromJson(Map<String, dynamic> json) {
    return WeekAttendance(
      weekNumber: json['weekNumber'],
      records: List<AttendanceRecord>.from(
          json['records'].map((x) => AttendanceRecord.fromJson(x))),
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
  final DateTime checkInTime;
  final DateTime sessionDate;
  final int weekNumber;
  final String sessionType;
  final String approved;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? checkOutTime;

  AttendanceRecord({
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
    this.checkOutTime,
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      id: json['_id'],
      student: Student.fromJson(json['student']),
      subject: json['subject'],
      group: json['group'],
      device: json['device'],
      status: json['status'],
      markedBy: json['marked_by'],
      checkInTime: DateTime.parse(json['checkInTime']),
      sessionDate: DateTime.parse(json['sessionDate']),
      weekNumber: json['weekNumber'],
      sessionType: json['sessionType'],
      approved: json['approved'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      checkOutTime: json['checkOutTime'] != null
          ? DateTime.parse(json['checkOutTime'])
          : null,
    );
  }
}

class Student {
  final String id;
  final User userId;
  final String studentName;
  final String? department;
  final int year;
  final List<String> groups;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String rfidTag;
  final String studentId;

  Student({
    required this.id,
    required this.userId,
    required this.studentName,
    this.department,
    required this.year,
    required this.groups,
    required this.createdAt,
    required this.updatedAt,
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
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
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
  final String role;
  final String phoneNumber;
  final bool isVerified;
  final String otp;
  final String expiresIn;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final Pfp pfp;

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
    required this.v,
    required this.pfp,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      universityEmail: json['university_email'],
      role: json['role'],
      phoneNumber: json['phoneNumber'],
      isVerified: json['isVerified'],
      otp: json['OTP'],
      expiresIn: json['expiresIn'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
      pfp: Pfp.fromJson(json['pfp']),
    );
  }
}

class Pfp {
  final String secureUrl;
  final String publicId;

  Pfp({required this.secureUrl, required this.publicId});

  factory Pfp.fromJson(Map<String, dynamic> json) {
    return Pfp(
      secureUrl: json['secure_url'],
      publicId: json['public_id'],
    );
  }
}
