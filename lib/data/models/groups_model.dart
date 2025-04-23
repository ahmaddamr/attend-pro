// ignore_for_file: avoid_print

import 'dart:convert';

class GroupModel {
  final String status;
  final int results;
  final List<GroupData> data;

  GroupModel({
    required this.status,
    required this.results,
    required this.data,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      status: json['status'] as String? ?? 'error',
      results: json['results'] as int? ?? 0,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => GroupData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'results': results,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static GroupModel? parse(String jsonString) {
    try {
      return GroupModel.fromJson(json.decode(jsonString));
    } catch (e) {
      print('Error parsing GroupModel: $e');
      return null;
    }
  }
}

class GroupData {
  final String id;
  final String name;
  final String subjectId;  // Simplified: Now just stores subject ID as string
  final List<StaffMember> staff;

  GroupData({
    required this.id,
    required this.name,
    required this.subjectId,
    required this.staff,
  });

  factory GroupData.fromJson(Map<String, dynamic> json) {
    return GroupData(
      id: json['_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      // Directly access subject ID without full Subject object
      subjectId: (json['subject_id'] is Map)
          ? (json['subject_id']['_id'] as String? ?? '')
          : (json['subject_id'] as String? ?? ''),
      staff: (json['staff'] as List<dynamic>?)
              ?.map((e) => StaffMember.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'subject_id': subjectId,  // Serializes as string
        'staff': staff.map((e) => e.toJson()).toList(),
      };
}

class StaffMember {
  final String staffId;
  final String role;
  final String id;

  StaffMember({
    required this.staffId,
    required this.role,
    required this.id,
  });

  factory StaffMember.fromJson(Map<String, dynamic> json) {
    return StaffMember(
      staffId: json['staff_id'] as String? ?? '',
      role: json['role'] as String? ?? '',
      id: json['_id'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'staff_id': staffId,
        'role': role,
        '_id': id,
      };
}