class CreateAnnounceModel {
  final String message;
  final Announcement announcement;

  CreateAnnounceModel({
    required this.message,
    required this.announcement,
  });

  factory CreateAnnounceModel.fromJson(Map<String, dynamic> json) {
    return CreateAnnounceModel(
      message: json['message'],
      announcement: Announcement.fromJson(json['announcement']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'announcement': announcement.toJson(),
    };
  }
}

class Announcement {
  final String content;
  final String createdBy;
  final String subject;
  final String group;
  final bool isDeleted;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Announcement({
    required this.content,
    required this.createdBy,
    required this.subject,
    required this.group,
    required this.isDeleted,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      content: json['content'],
      createdBy: json['createdBy'],
      subject: json['subject'],
      group: json['group'],
      isDeleted: json['isDeleted'],
      id: json['_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'createdBy': createdBy,
      'subject': subject,
      'group': group,
      'isDeleted': isDeleted,
      '_id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}
