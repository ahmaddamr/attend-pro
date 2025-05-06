import 'dart:developer';
import 'package:attend_pro/data/models/all_schedules_model.dart';
import 'package:attend_pro/data/models/my_schedule_model.dart';
import 'package:attend_pro/data/models/new_all_schedules_model.dart';
import 'package:attend_pro/domain/use_cases/get_all_schedules_use_case.dart';
import 'package:attend_pro/domain/use_cases/get_my_schedules_use_case.dart';
import 'package:attend_pro/domain/use_cases/new_all_schedules_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'schedules_state.dart';

class SchedulesCubit extends Cubit<SchedulesState> {
  SchedulesCubit() : super(SchedulesInitial());
  static SchedulesCubit get(BuildContext context) => BlocProvider.of(context);

  GetAllSchedulesUseCase useCase = GetAllSchedulesUseCase();
  GetMySchedulesUseCase mySchedulesUseCase = GetMySchedulesUseCase();
  NewAllSchedulesUseCase newAllSchedulesUseCase = NewAllSchedulesUseCase();
  NewAllSchedulesModel? model;
  List<ScheduleGroup> schedules = [];
  List<ScheduleItems> mySchedules = [];
  Future<void> getAllSchedules() async {
    emit(SchedulesLoading());
    try {
      schedules = await useCase.getAllSchedules();
      emit(SchedulesSuccess());
    } catch (e, stackTrace) {
      log('❌ Error in getAllSchedules Cubit: $e');
      log('📍 Stack trace: $stackTrace');
      emit(
        SchedulesFailure(
          msg: e.toString(),
        ),
      );
    }
  }

  Future<void> getMySchedules() async {
    emit(MySchedulesLoading());
    try {
      mySchedules = await mySchedulesUseCase.getMySchedules();
      emit(MySchedulesSuccess());
    } catch (e, stackTrace) {
      log('❌ Error in getMySchedules Cubit: $e');
      log('📍 Stack trace: $stackTrace');
      emit(
        MySchedulesFailure(
          msg: e.toString(),
        ),
      );
    }
  }

  Future<void> getNewSchedules() async {
    emit(NewAllSchedulesLoading());
    try {
      model = await newAllSchedulesUseCase.getAllNewSchedules();
      emit(NewAllSchedulesSuccess());
    } catch (e, stackTrace) {
      log('❌ Error in getNewSchedules Cubit: $e');
      log('📍 Stack trace: $stackTrace');
      emit(
        NewAllSchedulesFailure(
          msg: e.toString(),
        ),
      );
    }
  }
}
