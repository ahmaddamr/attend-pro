import 'dart:developer';

import 'package:attend_pro/data/models/week_attendance_model.dart';
import 'package:attend_pro/domain/use_cases/get_group_attendance_use_case.dart';
import 'package:attend_pro/presentation/manager/cubit/attendance_cubit/attendance_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit() : super(AttendanceInitial());
  static AttendanceCubit get(BuildContext context) => BlocProvider.of(context);
  GetGroupAttendanceUseCase getGroupAttendanceUseCase =
      GetGroupAttendanceUseCase();
  List<WeekAttendance> data = [];
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
}
