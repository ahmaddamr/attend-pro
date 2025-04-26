// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';

abstract class DataSource {
  Future<Response> StudentSignUp({
    required String firstName,
    required String lastName,
    required String email,
    required String university_email,
    required String password,
    required String phoneNumber,
    required File image,
  });
  Future<Response> login({required String email, required String password});
  Future<Response> logout();
  Future<Response> staffSignUp({
    required String firstName,
    required String lastName,
    required String email,
    required String university_email,
    required String password,
    required String phoneNumber,
  });
  Future<Response> getAllHalls();
  Future<Response> getAllSubjects();
  Future<Response> getCourses();
  Future<Response> getGroups(String id);
  Future<Response> getAllSchedules();
  Future<Response> getMySchedules();
  Future<Response> getGroupAttendance(String id);
  Future<Response> getStudentAttendance(String id);
  Future<Response> getWarnings();
  Future<Response> getAttendanceData(String id, String date, String type);
  Future<Response> selectHall(String hallId,
      {required String subjectId,
      required String groupId,
      required int weekNumber,
      required String sessionType});
  Future<Response> cancelHall(String id);
  Future<Response> startCheck(String id);
  Future<Response> endCheck(String id);
  Future<Response> startCheckOut(String id);
  Future<Response> endCheckOut(String id);
  Future<Response> createannouncement(
      {required String content,
      required String groupId,
      required String subjectId});
}
