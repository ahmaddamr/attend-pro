class LoginModel {
  final String message;
  final String accessToken;
  final UserModel? user;

  LoginModel({
    required this.message,
    required this.accessToken,
    required this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      message: json['message'],
      accessToken: json['accessToken'],
      user: UserModel.fromJson(json['user']),
    );
  }
}

class UserModel {
  final String userId;
  final String email;
  final String role;
  final String id;
  final String staffName;
  final String staffNumber;
  final String department;
  final String position;
  final List<String> subjects;
  final DateTime joinDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  UserModel({
    required this.userId,
    required this.email,
    required this.role,
    required this.id,
    required this.staffName,
    required this.staffNumber,
    required this.department,
    required this.position,
    required this.subjects,
    required this.joinDate,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      email: json['email'],
      role: json['role'],
      id: json['_id'],
      staffName: json['staff_name'],
      staffNumber: json['staff_number'],
      department: json['department'],
      position: json['position'],
      subjects: List<String>.from(json['subjects']),
      joinDate: DateTime.parse(json['join_date']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}
