// ignore_for_file: non_constant_identifier_names
import 'dart:io';
import 'package:attend_pro/data/repo/home_repo_implementation.dart';
import 'package:attend_pro/domain/repo/home_repo.dart';
import '../data/models/login_model.dart';
import '../data/models/logout_model.dart';
import '../data/models/students_signup_model.dart';

class UseCase {
  HomeRepo repo = HomeRepoImplementation();
  Future<StudentsSignUpModel> studentSignUp(
      {required String firstName,
      required String lastName,
      required String email,
      required String university_email,
      required String password,
      required String phoneNumber,
      required File image}) async {
    return await repo.studentSignUp(
        firstName: firstName,
        lastName: lastName,
        email: email,
        university_email: university_email,
        password: password,
        phoneNumber: phoneNumber,
        image: image);
  }

  Future<LoginModel> login(
      {required String email, required String password}) async {
    return await repo.login(email: email, password: password);
  }

  Future<LogoutModel> logout() async {
    return await repo.logout();
  }
}
