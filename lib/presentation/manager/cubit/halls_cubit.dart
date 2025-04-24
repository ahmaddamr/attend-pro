import 'dart:developer';

import 'package:attend_pro/data/models/cancel_hall_model.dart';
import 'package:attend_pro/data/models/get_halls_model.dart';
import 'package:attend_pro/data/models/select_hall_model.dart';
import 'package:attend_pro/domain/use_cases/cancel_hall_use_case.dart';
import 'package:attend_pro/domain/use_cases/get_halls_use_case.dart';
import 'package:attend_pro/domain/use_cases/select_hall_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'halls_state.dart';

class HallsCubit extends Cubit<HallsState> {
  HallsCubit() : super(HallsInitial());

  static HallsCubit get(BuildContext context) => BlocProvider.of(context);

  final GetHallsUseCase useCase = GetHallsUseCase();
  SelectHallUseCase hallUseCase = SelectHallUseCase();
  CancelHallUseCase cancelHallUseCase = CancelHallUseCase();
  SelectHallModel? model;
  CancelHallModel? cancelHallModel;

  List<HallDevice> data = [];

  Future<void> getHalls() async {
    emit(HallsLoading());
    try {
      data = await useCase.getHalls();
      log('✅ Fetched Halls: ${data.length} items');
      emit(HallsSuccess());
    } catch (e, stackTrace) {
      log('❌ Error in getHalls Cubit: $e');
      log('📍 Stack trace: $stackTrace');
      emit(HallsError(msg: e.toString()));
    }
  }

  Future<void> selectHall(String hallId,
      {required String subjectId,
      required String groupId,
      required int weekNumber,
      required String sessionType}) async {
    emit(SelectHallsLoading());
    try {
      model = await hallUseCase.selectHall(hallId,
          subjectId: subjectId,
          groupId: groupId,
          weekNumber: weekNumber,
          sessionType: sessionType);
      log('✅ Selected Hall: $model');
      emit(SelectHallsSuccess());
    } catch (e, stackTrace) {
      log('❌ Error in selectHall Cubit: $e');
      log('📍 Stack trace: $stackTrace');
      emit(SelectHallsFailure(msg: e.toString()));
    }
  }

  Future<void> cancelHall(String id) async {
    emit(CancelHallsLoading());
    try {
      cancelHallModel = await cancelHallUseCase.cancelHall(id);
      log('✅ Cancelled Hall: $cancelHallModel');
      emit(CancelHallsSuccess());
    } catch (e, stackTrace) {
      log('❌ Error in cancelHall Cubit: $e');
      log('📍 Stack trace: $stackTrace');
      emit(CancelHallsFailure(msg: e.toString()));
    }
  }
}
