class LogoutModel {
  final String msg;

  LogoutModel({required this.msg});

  factory LogoutModel.fromJson(Map<String, dynamic> json) {
    return LogoutModel(
      msg: json['msg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'msg': msg,
    };
  }
}
