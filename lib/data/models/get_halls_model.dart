class GetHallsModel {
  final int count;
  final List<HallDevice> devices;

  GetHallsModel({
    required this.count,
    required this.devices,
  });

  factory GetHallsModel.fromJson(Map<String, dynamic> json) {
    // Parse devices (ensure it's a List, default to empty list)
    final devices = (json['devices'] as List<dynamic>?)
        ?.map((e) => HallDevice.fromJson(e))
        .toList() ?? [];

    return GetHallsModel(
      count: _parseInt(json['count']) ?? 0,
      devices: devices,
    );
  }

  // Helper for safe integer parsing
  static int? _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}

class HallDevice {
  final String? id;
  final String? deviceId;
  final String? location;
  final String? status;
  final String? currentSubjectId;
  final String? currentGroupId;
  final String? sessionMode;
  final String? sessionType;
  final int? weekNumber;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  HallDevice({
    this.id,
    this.deviceId,
    this.location,
    this.status,
    this.currentSubjectId,
    this.currentGroupId,
    this.sessionMode,
    this.sessionType,
    this.weekNumber,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory HallDevice.fromJson(Map<String, dynamic> json) {
    return HallDevice(
      id: _parseString(json['_id']),
      deviceId: _parseString(json['device_id']),
      location: _parseString(json['location']),
      status: _parseString(json['status']),
      currentSubjectId: _parseString(json['currentSubjectId']),
      currentGroupId: _parseString(json['currentGroupId']),
      sessionMode: _parseString(json['sessionMode']),
      sessionType: _parseString(json['sessionType']),
      weekNumber: _parseInt(json['weekNumber']),
      createdAt: _parseString(json['createdAt']),
      updatedAt: _parseString(json['updatedAt']),
      v: _parseInt(json['__v']),
    );
  }

  // Helper for safe string parsing (handles nulls and nested Maps)
  static String? _parseString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is Map<String, dynamic>) {
      // Example: If field is a Map, extract a nested value (e.g., `name`)
      return value['name']?.toString();
    }
    return value.toString();
  }

  // Helper for safe integer parsing
  static int? _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}