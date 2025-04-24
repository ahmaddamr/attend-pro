class CancelHallModel {
  final String message;
  final Device device;

  CancelHallModel({
    required this.message,
    required this.device,
  });

  factory CancelHallModel.fromJson(Map<String, dynamic> json) {
    return CancelHallModel(
      message: json['message'] ?? '',
      device: Device.fromJson(json['device'] ?? {}),
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
  final String? currentSubjectId;
  final String? currentGroupId;
  final String? sessionMode;
  final String createdAt;
  final String updatedAt;

  Device({
    required this.id,
    required this.deviceId,
    required this.location,
    required this.status,
    this.currentSubjectId,
    this.currentGroupId,
    this.sessionMode,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['_id'] ?? '',
      deviceId: json['device_id'] ?? '',
      location: json['location'] ?? '',
      status: json['status'] ?? '',
      currentSubjectId: json['currentSubjectId'],
      currentGroupId: json['currentGroupId'],
      sessionMode: json['sessionMode'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
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
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
