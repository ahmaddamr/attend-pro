class AllSchedulesModel {
  final String message;
  final List<ScheduleGroup> schedules;

  AllSchedulesModel({
    required this.message,
    required this.schedules,
  });

  factory AllSchedulesModel.fromJson(Map<String, dynamic> json) {
    return AllSchedulesModel(
      message: json['message'],
      schedules: List<ScheduleGroup>.from(
        json['schedules'].map((x) => ScheduleGroup.fromJson(x)),
      ),
    );
  }
}

class ScheduleGroup {
  final String id;
  final int year;
  final String groupName;
  final List<ScheduleItem> schedule;
  final String createdAt;
  final String updatedAt;

  ScheduleGroup({
    required this.id,
    required this.year,
    required this.groupName,
    required this.schedule,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ScheduleGroup.fromJson(Map<String, dynamic> json) {
    return ScheduleGroup(
      id: json['_id'],
      year: json['year'],
      groupName: json['group_name'],
      schedule: List<ScheduleItem>.from(
        json['schedule'].map((x) => ScheduleItem.fromJson(x)),
      ),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class ScheduleItem {
  final Subjects subject;
  final String day;
  final String sessionType; // <-- Added this field
  final String startTime;
  final String endTime;
  final String location;
  final String id;

  ScheduleItem({
    required this.subject,
    required this.day,
    required this.sessionType, // <-- Added this parameter
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.id,
  });

  factory ScheduleItem.fromJson(Map<String, dynamic> json) {
    return ScheduleItem(
      subject: Subjects.fromJson(json['subject_id']),
      day: json['day'],
      sessionType: json['sessionType'], // <-- Parsing the new field
      startTime: json['startTime'],
      endTime: json['endTime'],
      location: json['location'],
      id: json['_id'],
    );
  }
}

class Subjects {
  final String id;
  final String name;

  Subjects({
    required this.id,
    required this.name,
  });

  factory Subjects.fromJson(Map<String, dynamic> json) {
    return Subjects(
      id: json['_id'],
      name: json['name'],
    );
  }
}
