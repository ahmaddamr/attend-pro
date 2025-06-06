// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:attend_pro/data/models/all_schedules_model.dart';
import 'package:attend_pro/data/models/cancel_hall_model.dart';
import 'package:attend_pro/data/models/create_announce_model.dart';
import 'package:attend_pro/data/models/end_check_model.dart';
import 'package:attend_pro/data/models/end_check_out_model.dart';
import 'package:attend_pro/data/models/group_announcements_model.dart';
import 'package:attend_pro/data/models/groups_model.dart';
import 'package:attend_pro/data/models/lecture_attendance_model.dart';
import 'package:attend_pro/data/models/logout_model.dart';
import 'package:attend_pro/data/models/my_schedule_model.dart';
import 'package:attend_pro/data/models/pending_model.dart';
import 'package:attend_pro/data/models/select_hall_model.dart';
import 'package:attend_pro/data/models/staff_subjects_model.dart';
import 'package:attend_pro/data/models/start_check_model.dart';
import 'package:attend_pro/data/models/start_check_out_model.dart';
import 'package:attend_pro/data/models/student_attendance_model.dart';
import 'package:attend_pro/data/models/subjects_model.dart';
import 'package:attend_pro/data/models/warning_model.dart';
import 'package:attend_pro/data/models/week_attendance_model.dart';

import '../../data/models/courses_model.dart';
import '../../data/models/get_halls_model.dart';
import '../../data/models/login_model.dart';
import '../../data/models/new_all_schedules_model.dart';
import '../../data/models/staff_signup_model.dart';
import '../../data/models/student_login_model.dart';
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
  Future<LoginModel> login({required String email, required String password});
  Future<StudentLoginModel> Studentlogin(
      {required String email, required String password});
  Future<LogoutModel> logout();
  Future<StaffSignUpModel> staffSignUp(
      {required String firstName,
      required String lastName,
      required String email,
      required String university_email,
      required String password,
      required String phoneNumber});
  Future<List<HallDevice>> getAllHalls();
  Future<List<SubjectData>> getAllSubjects();
  Future<List<CourseSubject>> getCourses();
  Future<List<GroupData>> getGroups(String id);
  Future<List<ScheduleGroup>> getAllSchedules();
  Future<List<ScheduleItems>> getMySchedules();
  Future<List<WeekAttendance>> getGroupAttendance(String id);
  Future<List<AttendanceData>> getStudentAttendance(String id);
  Future<WarningModel> getWarnings();
  Future<LectureAttendanceModel> getAttendanceData(
      String id, String date, String type);
  Future<SelectHallModel> selectHall(String hallId,
      {required String subjectId,
      required String groupId,
      // required int weekNumber,
      required String sessionType});
  Future<CancelHallModel> cancelHall(String id);
  Future<StartCheckModel> startCheck(String id);
  Future<EndCheckModel> endCheck(String id);
  Future<StartCheckOutModel> StartCheckOut(String id);
  Future<EndCheckOutModel> endCheckOut(String id);
  Future<CreateAnnounceModel> createannouncement(
      {required String content,
      required String groupId,
      required String subjectId});
  Future<List<GroupAnnouncementModel>> getgroupAnnouncement(String id);
  Future<List<GroupAnnouncementModel>> getStudentAnnouncement();
  Future<List<StaffSubjectData>> getStaffSubjects();
  Future<NewAllSchedulesModel> getNewAllSchedules();
  Future<PendingModel> acceptPending(
    String groupId, {
    required String sessionDate,
    required String sessionType,
  });
}
