import 'dart:developer';

import 'package:attend_pro/data/models/get_halls_model.dart';
import 'package:attend_pro/domain/use_cases/get_halls_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'halls_state.dart';

class HallsCubit extends Cubit<HallsState> {
  HallsCubit() : super(HallsInitial());

  static HallsCubit get(BuildContext context) => BlocProvider.of(context);

  final GetHallsUseCase useCase = GetHallsUseCase();

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
}
