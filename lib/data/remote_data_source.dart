// ignore_for_file: non_constant_identifier_names, avoid_print
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  Future<Response> logout() async {
    return dio.post('/auth/logout');
  }

  @override
  Future<Response> staffSignUp({
    required String firstName,
    required String lastName,
    required String email,
    required String university_email,
    required String password,
    required String phoneNumber,
  }) {
    FormData formData = FormData.fromMap({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'university_email': university_email,
      'password': password,
      'phoneNumber': phoneNumber,
    });

    return dio.post('/auth/staff/signUp', data: formData);
  }

  @override
  Future<Response> getAllHalls() async {
    final prefs = await SharedPreferences.getInstance();
    return dio.get(
      '/devices/getAllHalls',
      options: Options(headers: {
        'accesstoken': 'accesstoken_${prefs.getString('token')}',
      }),
    );
  }

  @override
  Future<Response> getAllSubjects() async {
    final prefs = await SharedPreferences.getInstance();
    return dio.get(
      '/students/getSubjectForStudent',
      options: Options(headers: {
        'accesstoken': 'accesstoken_${prefs.getString('token')}',
      }),
    );
  }

  @override
  Future<Response> getCourses() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? '';

    return dio.get(
      '/subjects/getAllSubjectForAstaff/$id',
      options: Options(
          headers: {'accesstoken': 'accesstoken_${prefs.getString('token')}'}),
    );
  }

  @override
  Future<Response> getGroups(String id) async {
    final prefs = await SharedPreferences.getInstance();
    String Uid = prefs.getString('userId') ?? '';
    log('uid is : $Uid');
    return dio.get(
      '/subjects/getSubjectsForStaffForSubject/staff/$Uid/subject/$id',
      options: Options(
          headers: {'accesstoken': 'accesstoken_${prefs.getString('token')}'}),
    );
  }

  @override
  Future<Response> getAllSchedules() async {
    final prefs = await SharedPreferences.getInstance();
    return dio.get(
      '/schedules/getAllSchedules',
      options: Options(headers: {
        'accesstoken': 'accesstoken_${prefs.getString('token')}',
      }),
    );
  }

  @override
  Future<Response> getMySchedules() async {
    final prefs = await SharedPreferences.getInstance();
    return dio.get('/schedules/get-user-schedule',
        options: Options(headers: {
          'accesstoken': 'accesstoken_${prefs.getString('token')}',
        }));
  }

  @override
  Future<Response> getGroupAttendance(String id) async {
    final prefs = await SharedPreferences.getInstance();
    return dio.get('/attendance/getWeeklyAttendanceForGroup/$id',
        options: Options(headers: {
          'accesstoken': 'accesstoken_${prefs.getString('token')}',
        }));
  }

  @override
  Future<Response> getStudentAttendance(String id) async {
    final prefs = await SharedPreferences.getInstance();

    return dio.get(
      '/attendance/getStudentAttendanceHistory/student/$id',
      options: Options(headers: {
        'accesstoken': 'accesstoken_${prefs.getString('token')}',
      }),
    );
  }

  @override
  Future<Response> getWarnings() async {
    final prefs = await SharedPreferences.getInstance();
    return dio.get(
      '/warnings/getMyWarnings',
      options: Options(headers: {
        'accesstoken': 'accesstoken_${prefs.getString('token')}',
      }),
    );
  }

  @override
  Future<Response> getAttendanceData(
      String id, String date, String type) async {
    final prefs = await SharedPreferences.getInstance();

    return dio.post('/attendance/getAttendanceResultsForSession/group/$id',
        options: Options(headers: {
          'accesstoken': 'accesstoken_${prefs.getString('token')}',
        }),
        data: {'sessionDate': date, 'sessionType': type});
  }

  @override
  Future<Response> selectHall(String hallId,
      {required String subjectId,
      required String groupId,
      // required int weekNumber,
      required String sessionType}) async {
    final prefs = await SharedPreferences.getInstance();
    return dio.patch(
      '/devices/selectHall/$hallId',
      data: {
        'subjectId': subjectId,
        'groupId': groupId,
        // 'weekNumber': weekNumber,
        'sessionType': sessionType
      },
      options: Options(
        headers: {
          'accesstoken': 'accesstoken_${prefs.getString('token')}',
        },
      ),
    );
  }

  @override
  Future<Response> cancelHall(String id) async {
    final prefs = await SharedPreferences.getInstance();
    return dio.patch(
      '/devices/cancel-selection/$id',
      options: Options(
        headers: {
          'accesstoken': 'accesstoken_${prefs.getString('token')}',
        },
      ),
    );
  }

  @override
  Future<Response> startCheck(String id) async {
    final prefs = await SharedPreferences.getInstance();
    return dio.patch(
      '/devices/start-check-in/$id',
      options: Options(
        headers: {
          'accesstoken': 'accesstoken_${prefs.getString('token')}',
        },
      ),
    );
  }

  @override
  Future<Response> endCheck(String id) async {
    final prefs = await SharedPreferences.getInstance();
    return dio.patch(
      '/devices/end-check-in/$id',
      options: Options(
        headers: {
          'accesstoken': 'accesstoken_${prefs.getString('token')}',
        },
      ),
    );
  }

  @override
  Future<Response> startCheckOut(String id) async {
    final prefs = await SharedPreferences.getInstance();
    return dio.patch(
      '/devices/start-check-out/$id',
      options: Options(
        headers: {
          'accesstoken': 'accesstoken_${prefs.getString('token')}',
        },
      ),
    );
  }

  @override
  Future<Response> endCheckOut(String id) async {
    final prefs = await SharedPreferences.getInstance();
    return dio.patch(
      '/devices/end-check-out/$id',
      options: Options(
        headers: {
          'accesstoken': 'accesstoken_${prefs.getString('token')}',
        },
      ),
    );
  }

  @override
  Future<Response> createannouncement(
      {required String content,
      required String groupId,
      required String subjectId}) async {
    final prefs = await SharedPreferences.getInstance();
    return dio.post(
      '/announcement/createAnnouncement',
      data: {
        'subject': subjectId,
        'group': groupId,
        'content': content,
      },
      options: Options(
        headers: {
          'accesstoken': 'accesstoken_${prefs.getString('token')}',
        },
      ),
    );
  }

  @override
  Future<Response> getgroupAnnouncement(String id) async {
    final prefs = await SharedPreferences.getInstance();
    return dio.get(
      '/announcement/getGroupAnnouncements/group/$id',
      options: Options(
        headers: {
          'accesstoken': 'accesstoken_${prefs.getString('token')}',
        },
      ),
    );
  }

  @override
  Future<Response> getStudentAnnouncement() async {
    final prefs = await SharedPreferences.getInstance();
    return dio.get(
      '/announcement/getStudentAnnouncements',
      options: Options(
        headers: {
          'accesstoken': 'accesstoken_${prefs.getString('token')}',
        },
      ),
    );
  }

  @override
  Future<Response> getStaffSubjects() async {
    final prefs = await SharedPreferences.getInstance();
    return dio.get(
      '/staff/getStaffSubjectsWithDetails',
      options: Options(
        headers: {
          'accesstoken': 'accesstoken_${prefs.getString('token')}',
        },
      ),
    );
  }

  @override
  Future<Response> getNewAllSchedules() async {
    final prefs = await SharedPreferences.getInstance();
    return dio.get(
      '/schedules/getAllSchedulesForMobile',
      options: Options(
        headers: {
          'accesstoken': 'accesstoken_${prefs.getString('token')}',
        },
      ),
    );
  }

  @override
  Future<Response> acceptPending(
    String groupId, {
    required String sessionDate,
    required String sessionType,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    return dio.patch(
      '/attendance/acceptAllPendingStudents/group/$groupId',
      data: {
        'sessionDate': sessionDate,
        'sessionType': sessionType,
      },
      options: Options(
        headers: {
          'accesstoken': 'accesstoken_${prefs.getString('token')}',
        },
      ),
    );
  }
}
