class StudentsSignUpModel {
  final String message;
  final StudentUser? user;

  StudentsSignUpModel({required this.message, required this.user});

  factory StudentsSignUpModel.fromJson(Map<String, dynamic> json) {
    return StudentsSignUpModel(
      message: json['message'],
      user: StudentUser.fromJson(json['user']),
    );
  }
}

class StudentUser {
  final String firstName;
  final String lastName;
  final String email;
  final String universityEmail;
  final String role;
  final String phoneNumber;
  final ProfilePicture pfp;
  final bool isVerified;
  final String otp;
  final String expiresIn;
  final List<dynamic> refreshTokens;
  final List<dynamic> tokenBlacklist;
  final String id;
  final String createdAt;
  final String updatedAt;
  final int v;

  StudentUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.universityEmail,
    required this.role,
    required this.phoneNumber,
    required this.pfp,
    required this.isVerified,
    required this.otp,
    required this.expiresIn,
    required this.refreshTokens,
    required this.tokenBlacklist,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory StudentUser.fromJson(Map<String, dynamic> json) {
    return StudentUser(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      universityEmail: json['university_email'],
      role: json['role'],
      phoneNumber: json['phoneNumber'],
      pfp: ProfilePicture.fromJson(json['pfp']),
      isVerified: json['isVerified'],
      otp: json['OTP'],
      expiresIn: json['expiresIn'],
      refreshTokens: List<dynamic>.from(json['refresh_tokens']),
      tokenBlacklist: List<dynamic>.from(json['token_blacklist']),
      id: json['_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}

class ProfilePicture {
  final String? secureUrl;
  final String? publicId;

  ProfilePicture({this.secureUrl, this.publicId});

  factory ProfilePicture.fromJson(Map<String, dynamic> json) {
    return ProfilePicture(
      secureUrl: json['secure_url'],
      publicId: json['public_id'],
    );
  }
}
