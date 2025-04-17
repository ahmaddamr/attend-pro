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
  

}
