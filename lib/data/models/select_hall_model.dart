class SelectHallModel {
  final String message;
  final Device device;

  SelectHallModel({
    required this.message,
    required this.device,
  });

  factory SelectHallModel.fromJson(Map<String, dynamic> json) {
    return SelectHallModel(
      message: json['message']?.toString() ?? '',
      device: json['device'] != null
          ? Device.fromJson(json['device'] as Map<String, dynamic>)
          : Device(
              id: '',
              deviceId: '',
              location: '',
              status: '',
              currentSubjectId: Subjectx(
                id: '',
                name: '',
                code: '',
                department: '',
                isDeleted: false,
                year: 0,
                groups: [],
                createdAt: '',
                updatedAt: '',
                version: 0,
              ),
              currentGroupId: Group(
                id: '',
                name: '',
                isDeleted: false,
                subjectId: '',
                students: [],
                staff: [],
                createdAt: '',
                updatedAt: '',
                version: 0,
              ),
              sessionMode: null,
              createdAt: '',
              updatedAt: '',
              version: 0,
            ),
    );
  }
}

class Device {
  final String id;
  final String deviceId;
  final String location;
  final String status;
  final Subjectx currentSubjectId;
  final Group currentGroupId;
  final String? sessionMode; // Nullable since it can be null
  final String createdAt;
  final String updatedAt;
  final int version;

  Device({
    required this.id,
    required this.deviceId,
    required this.location,
    required this.status,
    required this.currentSubjectId,
    required this.currentGroupId,
    this.sessionMode,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['_id']?.toString() ?? '',
      deviceId: json['device_id']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      currentSubjectId: json['currentSubjectId'] != null
          ? Subjectx.fromJson(json['currentSubjectId'] as Map<String, dynamic>)
          : Subjectx(
              id: '',
              name: '',
              code: '',
              department: '',
              isDeleted: false,
              year: 0,
              groups: [],
              createdAt: '',
              updatedAt: '',
              version: 0,
            ),
      currentGroupId: json['currentGroupId'] != null
          ? Group.fromJson(json['currentGroupId'] as Map<String, dynamic>)
          : Group(
              id: '',
              name: '',
              isDeleted: false,
              subjectId: '',
              students: [],
              staff: [],
              createdAt: '',
              updatedAt: '',
              version: 0,
            ),
      sessionMode: json['sessionMode']?.toString(),
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      version: _parseInt(json['__v']) ?? 0,
    );
  }

  static int? _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}

class Subjectx {
  final String id;
  final String name;
  final String code;
  final String department;
  final bool isDeleted;
  final int year;
  final List<String> groups;
  final String createdAt;
  final String updatedAt;
  final int version;

  Subjectx({
    required this.id,
    required this.name,
    required this.code,
    required this.department,
    required this.isDeleted,
    required this.year,
    required this.groups,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory Subjectx.fromJson(Map<String, dynamic> json) {
    return Subjectx(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
      department: json['department']?.toString() ?? '',
      isDeleted: json['isDeleted'] as bool? ?? false,
      year: _parseInt(json['year']) ?? 0,
      groups: (json['groups'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      version: _parseInt(json['__v']) ?? 0,
    );
  }

  static int? _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}

class Group {
  final String id;
  final String name;
  final bool isDeleted;
  final String subjectId;
  final List<String> students;
  final List<String> staff;
  final String createdAt;
  final String updatedAt;
  final int version;

  Group({
    required this.id,
    required this.name,
    required this.isDeleted,
    required this.subjectId,
    required this.students,
    required this.staff,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      isDeleted: json['isDeleted'] as bool? ?? false,
      subjectId: json['subject_id']?.toString() ?? '',
      students: (json['students'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      staff: (json['staff'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      version: _parseInt(json['__v']) ?? 0,
    );
  }

  static int? _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}
