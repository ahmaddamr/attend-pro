import 'dart:developer';

import 'package:attend_pro/data/models/lecture_attendance_model.dart';
import 'package:attend_pro/data/models/student_attendance_model.dart';
import 'package:attend_pro/data/models/warning_model.dart';
import 'package:attend_pro/data/models/week_attendance_model.dart';
import 'package:attend_pro/domain/use_cases/get_attendance_data_use_case.dart';
import 'package:attend_pro/domain/use_cases/get_group_attendance_use_case.dart';
import 'package:attend_pro/domain/use_cases/student_attendance_use_case.dart';
import 'package:attend_pro/domain/use_cases/warning_use_case.dart';
import 'package:attend_pro/presentation/manager/cubit/attendance_cubit/attendance_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit() : super(AttendanceInitial());
  static AttendanceCubit get(BuildContext context) => BlocProvider.of(context);
  GetGroupAttendanceUseCase getGroupAttendanceUseCase =
      GetGroupAttendanceUseCase();
  StudentAttendanceUseCase getStudentAttendanceUseCase =
      StudentAttendanceUseCase();
  WarningUseCase warningUseCase = WarningUseCase();
  List<WeekAttendance> data = [];
  List<AttendanceData> attendance = [];
  WarningModel? warning;
  GetAttendanceDataUseCase call = GetAttendanceDataUseCase();
  LectureAttendanceModel? lectureAttendanceModel;
  
  Future<void> getGroupAttendance(String id) async {
    emit(AttendanceLoading());
    try {
      data = await getGroupAttendanceUseCase.getgroupAttendance(id);
      emit(AttendanceSuccess());
    } catch (e, stackTrace) {
      log('❌ Error in getHalls Cubit: $e');
      log('📍 Stack trace: $stackTrace');
      emit(AttendanceError(msg: e.toString()));
    }
  }

  Future<void> getStudentAttendance(String id) async {
    emit(StudentAttendanceLoading());
    try {
      attendance = await getStudentAttendanceUseCase.getStudentAttendance(id);
      emit(StudentAttendanceSuccess());
    } catch (e, stackTrace) {
      log('❌ Error in student Cubit: $e');
      log('📍 Stack trace: $stackTrace');
      emit(StudentAttendanceFailure(msg: e.toString()));
    }
  }

  Future<void> getWarnings() async {
    emit(WarningLoading());
    try {
      warning = await warningUseCase.getWarnings();
      emit(WarningSuccess());
    } catch (e, stackTrace) {
      log('❌ Error in warning Cubit: $e');
      log('📍 Stack trace: $stackTrace');
      emit(WarningFailure(msg: e.toString()));
    }
  }

  Future<void> getSessionData(String id, String date, String type) async {
    emit(SessionDataLoading());
    try {
      lectureAttendanceModel = await call.execute(id, date, type);
      emit(SessionDataSuccess());
    } catch (e, stackTrace) {
      log('❌ Error in getSessionData Cubit: $e');
      log('📍 Stack trace: $stackTrace');
      emit(SessionDataFailure(msg: e.toString()));
    }
  }
}
