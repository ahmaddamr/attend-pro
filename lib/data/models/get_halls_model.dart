class GetHallsModel {
  final int? count;
  final List<HallDevice>? devices;

  GetHallsModel({
    this.count,
    this.devices,
  });

  factory GetHallsModel.fromJson(Map<String, dynamic> json) {
    return GetHallsModel(
      count: json['count'],
      devices: (json['devices'] as List<dynamic>?)
          ?.map((e) => HallDevice.fromJson(e))
          .toList(),
    );
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
      id: json['_id'],
      deviceId: json['device_id'],
      location: json['location'],
      status: json['status'],
      currentSubjectId: json['currentSubjectId'],
      currentGroupId: json['currentGroupId'],
      sessionMode: json['sessionMode'],
      sessionType: json['sessionType'],
      weekNumber: json['weekNumber'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}
