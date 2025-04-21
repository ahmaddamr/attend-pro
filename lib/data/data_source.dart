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
}
