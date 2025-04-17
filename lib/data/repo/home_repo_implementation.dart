// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'dart:io';

import 'package:attend_pro/data/data_source.dart';
import 'package:attend_pro/data/models/login_model.dart';
import 'package:attend_pro/data/models/logout_model.dart';
import 'package:attend_pro/data/models/staff_signup_model.dart';
import 'package:attend_pro/data/models/students_signup_model.dart';
import 'package:attend_pro/data/remote_data_source.dart';
import 'package:attend_pro/domain/repo/home_repo.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepoImplementation implements HomeRepo {
  DataSource dataSource = RemoteDataSource();

  @override
  Future<StudentsSignUpModel> studentSignUp({
    required String firstName,
    required String lastName,
    required String email,
    required String university_email,
    required String password,
    required String phoneNumber,
    required File image,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await dataSource.StudentSignUp(
        firstName: firstName,
        lastName: lastName,
        email: email,
        university_email: university_email,
        password: password,
        phoneNumber: phoneNumber,
        image: image,
      );

      log('Response status: ${response.statusCode}, message: ${response.statusMessage}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        var model = StudentsSignUpModel.fromJson(response.data);
        prefs.setString('fname', response.data['firstName']);
        prefs.setString('lname', response.data['lastName']);
        prefs.setString('email', response.data['university_email']);
        log('Success: ${model.user}');
        return model;
      } else {
        log('Registration failed: ${response.data}');

        if (response.data is Map && response.data.containsKey('message')) {
          throw Exception(response.data['message']);
        } else {
          throw Exception('Registration failed. Unexpected response format.');
        }
      }
    } catch (e) {
      log('Exception in register: $e');

      /// Return a default model with the error message instead of throwing an exception.
      return StudentsSignUpModel(
        message: e.toString(),
        user: null,
      );
    }
  }

  @override
  Future<LoginModel> login(
      {required String email, required String password}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await dataSource.login(email: email, password: password);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var model = LoginModel.fromJson(response.data);
        prefs.setString('token', response.data['accessToken']);
        log('Token: ${response.data['accessToken']}');

        log('Success Login: ${model.user}');
        return model;
      } else {
        throw Exception('Login failed. Unexpected response format.');
      }
    } catch (e) {
      log('Exception in Login: $e');
      return LoginModel(msg: e.toString(), accessToken: '', user: null);
    }
  }

  @override
  Future<LogoutModel> logout() async {
    try {
      var response = await dataSource.logout();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var model = LogoutModel.fromJson(response.data);
        log('Success Logout');
        return model;
      } else {
        throw Exception('Logout failed. Unexpected response format.');
      }
    } catch (e) {
      log('Exception in Login: $e');
      return LogoutModel(msg: e.toString());
    }
  }

  @override
  Future<StaffSignUpModel> staffSignUp({
    required String firstName,
    required String lastName,
    required String email,
    required String university_email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      var response = await dataSource.staffSignUp(
        firstName: firstName,
        lastName: lastName,
        email: email,
        university_email: university_email,
        password: password,
        phoneNumber: phoneNumber,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var model = StaffSignUpModel.fromJson(response.data);
        log('✅ Success: ${model.user}');
        return model;
      } else {
        // Log the full request on error
        log(response.data.toString());
        log('❌ Error Response: ${response.statusCode}');
        log('Request URL: ${response.requestOptions.uri}');
        log('Method: ${response.requestOptions.method}');
        log('Headers: ${response.requestOptions.headers}');
        log('Data: ${response.requestOptions.data}');
        throw Exception(
            'Registration failed with status code ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        final request = e.requestOptions;
        log('❌ DioException caught: ${e.message}');
        log('Request URL: ${request.uri}');
        log('Method: ${request.method}');
        log('Headers: ${request.headers}');
        log('Data: ${request.data}');
      } else {
        log('❌ General exception: $e');
      }

      return StaffSignUpModel(
        message: 'Exception: $e',
        user: null,
      );
    }
  }
}
