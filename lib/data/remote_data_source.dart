// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';

import 'data_source.dart';

class RemoteDataSource implements DataSource {
  final Dio dio = Dio(BaseOptions(
      baseUrl: 'https://attend-pro.onrender.com',
      followRedirects: false,
      validateStatus: (status) => status! < 500));
  @override
  Future<Response> StudentSignUp({
    required String firstName,
    required String lastName,
    required String email,
    required String university_email,
    required String password,
    required String phoneNumber,
    required File image,
  }) async {
    String fileName = image.path.split('/').last;

    FormData formData = FormData.fromMap({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'university_email': university_email,
      'password': password,
      'phoneNumber': phoneNumber,
      'image': await MultipartFile.fromFile(image.path, filename: fileName),
    });
    return dio.post('/auth/student/signUp', data: formData);
  }
  // Future<Response> StudentSignUp(
  //     {required String firstName,
  //     required String lastName,
  //     required String email,
  //     required String university_email,
  //     required String password,
  //     required String phoneNumber,
  //     required File image}) {
  //   return dio.post('/auth/student/signUp', data: {
  //     'firstName': firstName,
  //     'lastName': lastName,
  //     'email': email,
  //     'universityEmail': university_email,
  //     'password': password,
  //     'phoneNumber': phoneNumber,
  //     'image': image
  //   });
  // }
}
