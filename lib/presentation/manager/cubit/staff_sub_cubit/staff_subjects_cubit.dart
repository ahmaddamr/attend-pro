import 'dart:developer';

import 'package:attend_pro/data/models/staff_subjects_model.dart';
import 'package:attend_pro/domain/use_cases/staff_subjects_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'staff_subjects_state.dart';

class StaffSubjectsCubit extends Cubit<StaffSubjectsState> {
  StaffSubjectsCubit() : super(StaffSubjectsInitial());
  static StaffSubjectsCubit get(BuildContext context) =>
      BlocProvider.of(context);
  List<StaffSubjectData> staffSubjects = [];
  StaffSubjectsUseCase useCase = StaffSubjectsUseCase();
  Future<void> getStaffSubjects() async {
    emit(StaffSubjectsLoading());
    try {
      staffSubjects = await useCase.getStaffSubjects();
      emit(StaffSubjectsSuccess());
    } catch (e, stackTrace) {
      log('❌ Error in getStaffSubjects Cubit: $e');
      log('📍 Stack trace: $stackTrace');
      emit(
        StaffSubjectsFailure(msg: e.toString()),
      );
    }
  }
}
