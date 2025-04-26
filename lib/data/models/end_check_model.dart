class EndCheckModel {
  final String message;
  final Device device;

  EndCheckModel({
    required this.message,
    required this.device,
  });

  factory EndCheckModel.fromJson(Map<String, dynamic> json) {
    return EndCheckModel(
      message: json['message'],
      device: Device.fromJson(json['device']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'device': device.toJson(),
    };
  }
}

class Device {
  final String id;
  final String deviceId;
  final String location;
  final String status;
  final String currentSubjectId;
  final String currentGroupId;
  final String? sessionMode; // Nullable
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Device({
    required this.id,
    required this.deviceId,
    required this.location,
    required this.status,
    required this.currentSubjectId,
    required this.currentGroupId,
    required this.sessionMode,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['_id'],
      deviceId: json['device_id'],
      location: json['location'],
      status: json['status'],
      currentSubjectId: json['currentSubjectId'],
      currentGroupId: json['currentGroupId'],
      sessionMode: json['sessionMode'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'device_id': deviceId,
      'location': location,
      'status': status,
      'currentSubjectId': currentSubjectId,
      'currentGroupId': currentGroupId,
      'sessionMode': sessionMode,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}