class StudentLoginModel {
  final String? message;
  final String? accessToken;
  final StudentUserModel? user;

  StudentLoginModel({
    this.message,
    this.accessToken,
    this.user,
  });

  factory StudentLoginModel.fromJson(Map<String, dynamic> json) {
    return StudentLoginModel(
      message: json['message'],
      accessToken: json['accessToken'],
      user:
          json['user'] != null ? StudentUserModel.fromJson(json['user']) : null,
    );
  }
}

class StudentUserModel {
  final String? userId;
  final String? email;
  final String? role;
  final String? studentId;

  StudentUserModel({
    this.userId,
    this.email,
    this.role,
    this.studentId,
  });

  factory StudentUserModel.fromJson(Map<String, dynamic> json) {
    return StudentUserModel(
      userId: json['user_id'],
      email: json['email'],
      role: json['role'],
      studentId: json['student_id'],
    );
  }
}
