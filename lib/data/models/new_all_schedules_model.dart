class NewAllSchedulesModel {
  final String message;
  final Map<String, Map<String, List<ScheduleItem>>> data;

  NewAllSchedulesModel({
    required this.message,
    required this.data,
  });

  factory NewAllSchedulesModel.fromJson(Map<String, dynamic> json) {
    return NewAllSchedulesModel(
      message: json['message'],
      data: (json['data'] as Map<String, dynamic>).map((day, sessionsMap) {
        return MapEntry(
          day,
          (sessionsMap as Map<String, dynamic>).map((timeSlot, sessionsList) {
            return MapEntry(
              timeSlot,
              (sessionsList as List<dynamic>)
                  .map((e) => ScheduleItem.fromJson(e))
                  .toList(),
            );
          }),
        );
      }),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((day, sessionsMap) {
        return MapEntry(
          day,
          sessionsMap.map((timeSlot, sessionsList) {
            return MapEntry(
              timeSlot,
              sessionsList.map((e) => e.toJson()).toList(),
            );
          }),
        );
      }),
    };
  }
}

class ScheduleItem {
  final String subjectId;
  final String subjectName;
  final String groupName;
  final String sessionType;
  final String location;

  ScheduleItem({
    required this.subjectId,
    required this.subjectName,
    required this.groupName,
    required this.sessionType,
    required this.location,
  });

  factory ScheduleItem.fromJson(Map<String, dynamic> json) {
    return ScheduleItem(
      subjectId: json['subject_id'],
      subjectName: json['subject_name'],
      groupName: json['group_name'],
      sessionType: json['sessionType'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject_id': subjectId,
      'subject_name': subjectName,
      'group_name': groupName,
      'sessionType': sessionType,
      'location': location,
    };
  }
}
