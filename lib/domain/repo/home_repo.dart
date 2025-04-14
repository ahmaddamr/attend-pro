// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import '../../data/models/students_signup_model.dart';

abstract class HomeRepo {
  Future<StudentsSignUpModel> studentSignUp(
      {required String firstName,
      required String lastName,
      required String email,
      required String university_email,
      required String password,
      required String phoneNumber,
      required File image});
}
