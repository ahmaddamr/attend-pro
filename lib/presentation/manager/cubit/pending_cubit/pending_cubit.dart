import 'dart:developer';

import 'package:attend_pro/data/models/pending_model.dart';
import 'package:attend_pro/domain/use_cases/accept_pending_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pending_state.dart';

class PendingCubit extends Cubit<PendingState> {
  PendingCubit() : super(PendingInitial());
  static PendingCubit get(BuildContext context) => BlocProvider.of(context);
  PendingModel? model;
  AcceptPendingUseCase useCase = AcceptPendingUseCase();
  Future<void> acceptPending(String groupId,
      {required String sessionDate, required String sessionType}) async {
    emit(AcceptPendingLoading());
    try {
      model = await useCase.acceptPending(groupId,
          sessionDate: sessionDate, sessionType: sessionType);
      emit(AcceptPendingSuccess());
    } catch (e, stackTrace) {
      log('❌ Error in getPending Cubit: $e');
      log('📍 Stack trace: $stackTrace');
      emit(AcceptPendingFailure(e.toString()));
    }
  }
}
