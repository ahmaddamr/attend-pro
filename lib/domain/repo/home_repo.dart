// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:attend_pro/data/models/logout_model.dart';

import '../../data/models/courses_model.dart';
import '../../data/models/get_halls_model.dart';
import '../../data/models/login_model.dart';
import '../../data/models/staff_signup_model.dart';
import '../../data/models/students_signup_model.dart';
import '../../data/models/subjects_model.dart';

abstract class HomeRepo {
  Future<StudentsSignUpModel> studentSignUp(
      {required String firstName,
      required String lastName,
      required String email,
      required String university_email,
      required String password,
      required String phoneNumber,
      required File image});
  Future<LoginModel> login({required String email, required String password});
  Future<LogoutModel> logout();
  Future<StaffSignUpModel> staffSignUp(
      {required String firstName,
      required String lastName,
      required String email,
      required String university_email,
      required String password,
      required String phoneNumber});
  Future<List<HallDevice>> getAllHalls();
  Future<List<Subject>> getAllSubjects();
  Future<List<CourseSubject>> getCourses();
}
