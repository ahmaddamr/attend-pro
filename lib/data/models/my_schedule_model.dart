class MyScheduleModel {
  final String message;
  final List<ScheduleItems> schedule;

  MyScheduleModel({
    required this.message,
    required this.schedule,
  });

  factory MyScheduleModel.fromJson(Map<String, dynamic> json) {
    return MyScheduleModel(
      message: json['message'] ?? '',
      schedule: (json['schedule'] as List)
          .map((item) => ScheduleItems.fromJson(item))
          .toList(),
    );
  }
}

class ScheduleItems {
  final Subjectl subject;
  final String day;
  final String sessionType; // ✅ New field
  final String startTime;
  final String endTime;
  final String location;
  final String id;

  ScheduleItems({
    required this.subject,
    required this.day,
    required this.sessionType,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.id,
  });

  factory ScheduleItems.fromJson(Map<String, dynamic> json) {
    return ScheduleItems(
      subject: Subjectl.fromJson(json['subject_id']),
      day: json['day'] ?? '',
      sessionType: json['sessionType'] ?? '', // ✅ Map sessionType
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      location: json['location'] ?? '',
      id: json['_id'] ?? '',
    );
  }
}

class Subjectl {
  final String id;
  final String name;

  Subjectl({
    required this.id,
    required this.name,
  });

  factory Subjectl.fromJson(Map<String, dynamic> json) {
    return Subjectl(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
