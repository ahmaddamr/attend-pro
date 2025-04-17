class LoginModel {
  final String msg;
  final String accessToken;
  final User? user;

  LoginModel({
    required this.msg,
    required this.accessToken,
    required this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      msg: json['msg'],
      accessToken: json['accessToken'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'msg': msg,
      'accessToken': accessToken,
      'user': user?.toJson(),
    };
  }
}

class User {
  final String id;
  final String email;
  final String role;

  User({
    required this.id,
    required this.email,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'role': role,
    };
  }
}
