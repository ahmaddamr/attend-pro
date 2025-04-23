class StudentAttendanceModel {
  final String message;
  final int total;
  final List<AttendanceData> data;

  StudentAttendanceModel({
    required this.message,
    required this.total,
    required this.data,
  });

  factory StudentAttendanceModel.fromJson(Map<String, dynamic> json) {
    // Handle null or missing 'data' field
    var dataList = json['data'] as List<dynamic>? ?? [];
    return StudentAttendanceModel(
      message: json['message']?.toString() ?? '',
      total: json['total'] is int ? json['total'] : 0,
      data: dataList
          .where((e) => e != null) // Filter out null elements
          .map((e) => AttendanceData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class AttendanceData {
  final String id;
  final Subjecta subjecta;
  final Group group;
  final String status;
  final String? checkInTime;
  final String? checkOutTime;
  final String sessionDate;
  final int weekNumber;
  final String sessionType;
  final String approved;

  AttendanceData({
    required this.id,
    required this.subjecta,
    required this.group,
    required this.status,
    this.checkInTime,
    this.checkOutTime,
    required this.sessionDate,
    required this.weekNumber,
    required this.sessionType,
    required this.approved,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      id: json['_id']?.toString() ?? '',
      // Handle null subjecta
      subjecta: json['subject'] != null
          ? Subjecta.fromJson(json['subject'] as Map<String, dynamic>)
          : Subjecta(id: '', name: '', code: ''),
      // Handle null group
      group: json['group'] != null
          ? Group.fromJson(json['group'] as Map<String, dynamic>)
          : Group(id: '', name: ''),
      status: json['status']?.toString() ?? '',
      checkInTime: json['checkInTime']?.toString(),
      checkOutTime: json['checkOutTime']?.toString(),
      sessionDate: json['sessionDate']?.toString() ?? '',
      weekNumber: json['weekNumber'] is int ? json['weekNumber'] : 0,
      sessionType: json['sessionType']?.toString() ?? '',
      approved: json['approved']?.toString() ?? '',
    );
  }
}

class Subjecta {
  final String id;
  final String name;
  final String code;

  Subjecta({
    required this.id,
    required this.name,
    required this.code,
  });

  factory Subjecta.fromJson(Map<String, dynamic> json) {
    return Subjecta(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
    );
  }
}

class Group {
  final String id;
  final String name;

  Group({
    required this.id,
    required this.name,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }
}