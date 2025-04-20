import 'dart:developer';

import 'package:attend_pro/domain/use_cases/get_group_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/models/groups_model.dart';

part 'groups_state.dart';

class GroupsCubit extends Cubit<GroupsState> {
  GroupsCubit() : super(GroupsInitial());
  static GroupsCubit get(BuildContext context) => BlocProvider.of(context);

  GetGroupUseCase useCase = GetGroupUseCase();
  List<GroupData> groups = [];
  String? id;
  Future<void> getGroups(String id) async {
    emit(GroupsLoading());
    try {
      groups = await useCase.getGroups(id ?? 'null');
      log("groups: ${groups.toString()}");
      emit(GroupsSuccess());
    } catch (e, stackTrace) {
      log('❌ Error in getGroups Cubit: $e');
      log('📍 Stack trace: $stackTrace');
      emit(GroupsFailure(msg: e.toString()));
    }
  }
}
