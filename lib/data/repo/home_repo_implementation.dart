// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'dart:io';

import 'package:attend_pro/data/data_source.dart';
import 'package:attend_pro/data/models/all_schedules_model.dart';
import 'package:attend_pro/data/models/cancel_hall_model.dart';
import 'package:attend_pro/data/models/courses_model.dart';
import 'package:attend_pro/data/models/create_announce_model.dart';
import 'package:attend_pro/data/models/end_check_model.dart';
import 'package:attend_pro/data/models/end_check_out_model.dart';
import 'package:attend_pro/data/models/get_halls_model.dart';
import 'package:attend_pro/data/models/group_announcements_model.dart';
import 'package:attend_pro/data/models/groups_model.dart';
import 'package:attend_pro/data/models/lecture_attendance_model.dart';
import 'package:attend_pro/data/models/login_model.dart';
import 'package:attend_pro/data/models/logout_model.dart';
import 'package:attend_pro/data/models/my_schedule_model.dart';
import 'package:attend_pro/data/models/new_all_schedules_model.dart';
import 'package:attend_pro/data/models/pending_model.dart';
import 'package:attend_pro/data/models/select_hall_model.dart';
import 'package:attend_pro/data/models/staff_signup_model.dart';
import 'package:attend_pro/data/models/staff_subjects_model.dart';
import 'package:attend_pro/data/models/start_check_model.dart';
import 'package:attend_pro/data/models/start_check_out_model.dart';
import 'package:attend_pro/data/models/student_attendance_model.dart';
import 'package:attend_pro/data/models/student_login_model.dart';
import 'package:attend_pro/data/models/students_signup_model.dart';
import 'package:attend_pro/data/models/subjects_model.dart';
import 'package:attend_pro/data/models/warning_model.dart';
import 'package:attend_pro/data/models/week_attendance_model.dart';
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
        prefs.setString('fname', response.data['user']['firstName'] ?? '');
        prefs.setString('lname', response.data['user']['lastName'] ?? '');
        prefs.setString(
            'email', response.data['user']['university_email'] ?? '');
        log('Success: ${model.user}');
        log('${response.data}');
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
        prefs.setString('userId', response.data['user']['_id']);
        log('Token: ${response.data['accessToken']}');
        log('UserId: ${response.data['user']['_id']}');
        log('Response Data: ${response.data}');
        log('Success Login: ${model.user}');
        return model;
      } else {
        throw Exception('Login failed. Unexpected response format.');
      }
    } catch (e) {
      log('Exception in Login: $e');
      return LoginModel(message: e.toString(), accessToken: '', user: null);
    }
  }

  @override
  Future<StudentLoginModel> Studentlogin(
      {required String email, required String password}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await dataSource.login(email: email, password: password);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var model = StudentLoginModel.fromJson(response.data);
        prefs.setString('token', response.data['accessToken']);
        prefs.setString('userId', response.data['user']['user_id']);
        prefs.setString('studentId', response.data['user']['student_id']);

        log('Token: ${response.data['accessToken']}');
        log('UserId: ${response.data['user']['user_id']}');
        log('Response Data: ${response.data}');
        log('Success Student Login: ${model.user}');
        return model;
      } else {
        throw Exception('Student Login failed. Unexpected response format.');
      }
    } catch (e) {
      log('Exception in Login: $e');
      return StudentLoginModel(
          message: e.toString(), accessToken: '', user: null);
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

  @override
  Future<List<HallDevice>> getAllHalls() async {
    var response = await dataSource.getAllHalls();
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = GetHallsModel.fromJson(response.data);
        log(data.devices.toString());
        return data.devices ?? [];
      } else {
        log('❌ Unexpected response: ${response.data}');
        return []; // Don't return the message directly, just log it and return empty list
      }
    } catch (e, stackTrace) {
      log('❌ Exception in getAllHalls: $e');
      log('📍 StackTrace: $stackTrace');
      return []; // Also return empty list here to avoid crashing the app
    }
  }

  @override
  Future<List<SubjectData>> getAllSubjects() async {
    var response = await dataSource.getAllSubjects();
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = SubjectsModel.fromJson(response.data);
        log(data.data.toString());
        return data.data ?? [];
      } else {
        log('❌ Unexpected response: ${response.data}');
        return [];
      }
    } catch (e, stackTrace) {
      log('❌ Exception in getSubjects: $e');
      log('📍 StackTrace: $stackTrace');
      return []; // Also return empty list here to avoid crashing the app
    }
  }

  @override
  Future<List<CourseSubject>> getCourses() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await dataSource.getCourses();
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = CoursesModel.fromJson(response.data);
        log(data.subjects.toString());
        prefs.setString('subId', response.data['subjects'][0]['_id']);
        log(response.data['subjects'][0]['_id']);

        return data.subjects ?? [];
      } else {
        log('❌ Unexpected response: ${response.data}');
        return [];
      }
    } catch (e, stackTrace) {
      log('❌ Exception in getCourses: $e');
      log('📍 StackTrace: $stackTrace');
      return []; // Also return empty list here to avoid crashing the app
    }
  }

  @override
  Future<List<GroupData>> getGroups(String id) async {
    var response = await dataSource.getGroups(id);
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = GroupModel.fromJson(response.data);
        return data.data ?? [];
      } else {
        log('❌ Unexpected response: ${response.data}');
        return [];
      }
    } catch (e, stackTrace) {
      log('❌ Exception in getGroups: $e');
      log('📍 StackTrace: $stackTrace');
      return []; // Also return empty list here to avoid crashing the app
    }
  }

  @override
  Future<List<ScheduleGroup>> getAllSchedules() async {
    var response = await dataSource.getAllSchedules();
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = AllSchedulesModel.fromJson(response.data);
        log(data.schedules.toString());
        return data.schedules ?? [];
      } else {
        log('❌ Unexpected response: ${response.data}');
        return [];
      }
    } catch (e, stackTrace) {
      log('❌ Exception in getSchedules: $e');
      log('📍 StackTrace: $stackTrace');
      return []; // Also return empty list here to avoid crashing the app
    }
  }

  @override
  Future<List<ScheduleItems>> getMySchedules() async {
    var response = await dataSource.getMySchedules();
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = MyScheduleModel.fromJson(response.data);
        log(data.schedule.toString());
        return data.schedule ?? [];
      } else {
        log('❌ Unexpected response: ${response.data}');
        return [];
      }
    } catch (e, stackTrace) {
      log('❌ Exception in getMySchedules: $e');
      log('📍 StackTrace: $stackTrace');
      return []; // Also return empty list here to avoid crashing the app
    }
  }

  @override
  Future<List<WeekAttendance>> getGroupAttendance(String id) async {
    var response = await dataSource.getGroupAttendance(id);
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = GroupAttendanceModel.fromJson(response.data);
        log(data.data.toString());
        return data.data ?? [];
      } else {
        log('❌ Unexpected response: ${response.data}');
        return [];
      }
    } catch (e, stackTrace) {
      log('❌ Exception in getGroupAttendance: $e');
      log('📍 StackTrace: $stackTrace');
      return []; // Also return empty list here to avoid crashing the app
    }
  }

  @override
  Future<List<AttendanceData>> getStudentAttendance(String id) async {
    var response = await dataSource.getStudentAttendance(id);
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = StudentAttendanceModel.fromJson(response.data);
        log(data.data.toString());
        return data.data ?? [];
      } else {
        log('❌ Unexpected response: ${response.data}');
        return [];
      }
    } catch (e, stackTrace) {
      log('❌ Exception in getStudentAttendance: $e');
      log('📍 StackTrace: $stackTrace');
      return []; // Also return empty list here to avoid crashing the app
    }
  }

  @override
  Future<WarningModel> getWarnings() async {
    var response = await dataSource.getWarnings();

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = WarningModel.fromJson(response.data);
        return data;
      } else {
        log('❌ Unexpected response: ${response.data}');
        throw Exception(
            'warning failed with status code ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LectureAttendanceModel> getAttendanceData(
      String id, String date, String type) async {
    var response = await dataSource.getAttendanceData(id, date, type);

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = LectureAttendanceModel.fromJson(response.data);
        return data;
      } else {
        log('❌ Unexpected response: ${response.data}');
        throw Exception(
            'warning failed with status code ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SelectHallModel> selectHall(String hallId,
      {required String subjectId,
      required String groupId,
      // required int weekNumber,
      required String sessionType}) async {
    var response = await dataSource.selectHall(hallId,
        subjectId: subjectId,
        groupId: groupId,
        // weekNumber: weekNumber,
        sessionType: sessionType);
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = SelectHallModel.fromJson(response.data);
        return data;
      } else {
        log('❌ Unexpected response: ${response.data}');
        throw Exception('Validation Error ');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CancelHallModel> cancelHall(String id) async {
    var response = await dataSource.cancelHall(id);
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = CancelHallModel.fromJson(response.data);
        log(data.message); // "Device reservation canceled successfully"
        log(data.device.location);
        return data;
      } else {
        log('❌ Unexpected response: ${response.data}');
        throw Exception(
            'warning failed with status code ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<StartCheckModel> startCheck(String id) async {
    var response = await dataSource.startCheck(id);
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = StartCheckModel.fromJson(response.data);
        log(data.message); // "Device reservation canceled successfully"
        log(data.device.location);
        return data;
      } else {
        log('❌ Unexpected response: ${response.data}');
        throw Exception(
            'warning failed with status code ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<EndCheckModel> endCheck(String id) async {
    var response = await dataSource.endCheck(id);
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = EndCheckModel.fromJson(response.data);
        log(data.message); // "Device reservation canceled successfully"
        log(data.device.location);
        return data;
      } else {
        log('❌ Unexpected response: ${response.data}');
        throw Exception(
            'warning failed with status code ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<StartCheckOutModel> StartCheckOut(String id) async {
    var response = await dataSource.startCheckOut(id);
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = StartCheckOutModel.fromJson(response.data);
        log(data.message);
        log(data.device.location);
        return data;
      } else {
        log('❌ Unexpected response: ${response.data}');
        throw Exception(
            'warning failed with status code ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<EndCheckOutModel> endCheckOut(String id) async {
    var response = await dataSource.endCheckOut(id);
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = EndCheckOutModel.fromJson(response.data);
        log(data.message);
        log(data.device.location);
        return data;
      } else {
        log('❌ Unexpected response: ${response.data}');
        throw Exception('warning failed with status ${response.statusMessage}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CreateAnnounceModel> createannouncement(
      {required String content,
      required String groupId,
      required String subjectId}) async {
    var response = await dataSource.createannouncement(
        content: content, groupId: groupId, subjectId: subjectId);
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = CreateAnnounceModel.fromJson(response.data);
        log(data.message);
        return data;
      } else {
        log('❌ Unexpected response: ${response.data}');
        throw Exception('warning failed with status ${response.statusMessage}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<GroupAnnouncementModel>> getgroupAnnouncement(String id) async {
    var response = await dataSource.getgroupAnnouncement(id);
    try {
      if (response.statusCode == 200) {
        List<GroupAnnouncementModel> announcements = (response.data as List)
            .map((json) => GroupAnnouncementModel.fromJson(json))
            .toList();
        return announcements;
      } else {
        throw Exception(
            'Failed to load announcements ${response.statusMessage}');
      }
    } on Exception catch (e) {
      throw Exception('Error getting announcements: $e');
    }
  }

  @override
  Future<List<GroupAnnouncementModel>> getStudentAnnouncement() async {
    var response = await dataSource.getStudentAnnouncement();
    try {
      if (response.statusCode == 200) {
        List<GroupAnnouncementModel> announcements = (response.data as List)
            .map((json) => GroupAnnouncementModel.fromJson(json))
            .toList();
        return announcements;
      } else {
        throw Exception(
            'Failed to load Student announcements ${response.statusMessage}');
      }
    } on Exception catch (e) {
      throw Exception('Error getting announcements: $e');
    }
  }

  @override
  Future<List<StaffSubjectData>> getStaffSubjects() async {
    var response = await dataSource.getStaffSubjects();
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = StaffSubjectsModel.fromJson(response.data);
        log(data.data.toString());
        return data.data;
      } else {
        log('❌ Unexpected response: ${response.data}');
        throw Exception('warning failed with status ${response.statusMessage}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<NewAllSchedulesModel> getNewAllSchedules() async {
    var response = await dataSource.getNewAllSchedules();
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = NewAllSchedulesModel.fromJson(response.data);
        log(data.data.toString());
        return data;
      } else {
        log('❌ Unexpected response: ${response.data}');
        throw Exception('warning failed with status ${response.statusMessage}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PendingModel> acceptPending(String groupId,
      {required String sessionDate, required String sessionType}) async {
    var response = await dataSource.acceptPending(groupId,
        sessionDate: sessionDate, sessionType: sessionType);
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = PendingModel.fromJson(response.data);
        log(data.data.toString());
        return data;
      } else {
        log('❌ Unexpected response: ${response.data}');
        throw Exception('warning failed with status ${response.statusMessage}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
