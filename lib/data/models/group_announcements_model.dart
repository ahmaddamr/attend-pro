class GroupAnnouncementModel {
  final String id;
  final String content;
  final CreatedBy createdBy;
  final Subjectg subject;
  final String groupId;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  GroupAnnouncementModel({
    required this.id,
    required this.content,
    required this.createdBy,
    required this.subject,
    required this.groupId,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GroupAnnouncementModel.fromJson(Map<String, dynamic> json) {
    return GroupAnnouncementModel(
      id: json['_id'] ?? '',
      content: json['content'] ?? '',
      createdBy: CreatedBy.fromJson(json['createdBy'] ?? {}),
      subject: Subjectg.fromJson(json['subject'] ?? {}),
      groupId: json['group'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'content': content,
      'createdBy': createdBy.toJson(),
      'subject': subject.toJson(),
      'group': groupId,
      'isDeleted': isDeleted,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class CreatedBy {
  final String id;
  final String staffName;

  CreatedBy({
    required this.id,
    required this.staffName,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['_id'] ?? '',
      staffName: json['staff_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'staff_name': staffName,
    };
  }
}

class Subjectg {
  final String id;
  final String name;
  final String code;

  Subjectg({
    required this.id,
    required this.name,
    required this.code,
  });

  factory Subjectg.fromJson(Map<String, dynamic> json) {
    return Subjectg(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      code: json['code'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'code': code,
    };
  }
}
