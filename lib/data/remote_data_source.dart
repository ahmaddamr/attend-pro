// ignore_for_file: non_constant_identifier_names, avoid_print
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'data_source.dart';
import 'package:http_parser/http_parser.dart'; // ✅ Import http_parser

class RemoteDataSource implements DataSource {
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://attend-pro.onrender.com',
    followRedirects: false,
    validateStatus: (status) => status! < 700,
  ));

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
    print('function triggered and image is not null = {${image.path}}');

    String fileName = image.path.split('/').last;

    FormData formData = FormData.fromMap({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'university_email': university_email,
      'password': password,
      'phoneNumber': phoneNumber,
      'image': await MultipartFile.fromFile(
        image.path,
        filename: fileName,
        contentType: MediaType('image', _getMimeType(image.path)),
      ),
    });

    print('Form fields: ${formData.fields}');
    print('Form files: ${formData.files}');

    return dio.post(
      '/auth/student/signUp',
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
        headers: {
          'Accept': 'application/json',
        },
      ),
    );
  }

  /// Helper method to get correct subtype (jpeg, png, webp, etc.)
  String _getMimeType(String path) {
    final ext = path.split('.').last.toLowerCase();
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return 'jpeg';
      case 'png':
        return 'png';
      case 'webp':
        return 'webp';
      default:
        return 'jpeg'; // default fallback
    }
  }

  @override
  Future<Response> login({required String email, required String password}) {
    return dio
        .post('/auth/login', data: {'email': email, 'password': password});
  }
  
  @override
  Future<Response> logout() async{
    return dio.post('/auth/logout');
  }
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

