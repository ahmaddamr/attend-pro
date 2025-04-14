// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names

import 'dart:developer';
import 'dart:io';

import 'package:attend_pro/data/data_source.dart';
import 'package:attend_pro/data/models/students_signup_model.dart';
import 'package:attend_pro/data/remote_data_source.dart';
import 'package:attend_pro/domain/repo/home_repo.dart';

class HomeRepoImplementation implements HomeRepo {
  DataSource dataSource = RemoteDataSource();
  @override
  Future<StudentsSignUpModel> studentSignUp(
      {required String firstName,
      required String lastName,
      required String email,
      required String university_email,
      required String password,
      required String phoneNumber,
      required File image}) async {
    try {
      var reposnse = await dataSource.StudentSignUp(
          firstName: firstName,
          lastName: lastName,
          email: email,
          university_email: university_email,
          password: password,
          phoneNumber: phoneNumber,
          image: image);
      log('Response status: ${reposnse.statusMessage}');
      if (reposnse.statusCode == 200 || reposnse.statusCode == 201) {
        var model = StudentsSignUpModel.fromJson(reposnse.data);
        log('Success ${model}');
        return model;
      } else {
        log('Registration failed: ${reposnse.data}');
        throw reposnse.data['message'] ?? 'Registration failed';
      }
    } catch (e) {
      log(
        'Exception in register: $e',
      );
      return StudentsSignUpModel(
      message: 'An error occurred: $e',
      user: null,
    );
    }
  }
}
