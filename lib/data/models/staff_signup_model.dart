class StaffSignUpModel {
  final String message;
  final StaffUser? user;

  StaffSignUpModel({
    required this.message,
    required this.user,
  });

  factory StaffSignUpModel.fromJson(Map<String, dynamic> json) {
    return StaffSignUpModel(
      message: json['message'],
      user: StaffUser.fromJson(json['user']),
    );
  }
}

class StaffUser {
  final String firstName;
  final String lastName;
  final String email;
  final String universityEmail;
  final String role;
  final String phoneNumber;
  final Pfp pfp;
  final bool isVerified;
  final String otp;
  final String expiresIn;
  final List<dynamic> refreshTokens;
  final List<dynamic> tokenBlacklist;
  final String id;
  final String createdAt;
  final String updatedAt;
  final int v;

  StaffUser({
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

  factory StaffUser.fromJson(Map<String, dynamic> json) {
    return StaffUser(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      universityEmail: json['university_email'],
      role: json['role'],
      phoneNumber: json['phoneNumber'],
      pfp: Pfp.fromJson(json['pfp']),
      isVerified: json['isVerified'],
      otp: json['OTP'],
      expiresIn: json['expiresIn'],
      refreshTokens: json['refresh_tokens'],
      tokenBlacklist: json['token_blacklist'],
      id: json['_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}

class Pfp {
  final String? secureUrl;
  final String? publicId;

  Pfp({
    this.secureUrl,
    this.publicId,
  });

  factory Pfp.fromJson(Map<String, dynamic> json) {
    return Pfp(
      secureUrl: json['secure_url'],
      publicId: json['public_id'],
    );
  }
}
