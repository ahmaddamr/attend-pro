import 'package:attend_pro/data/models/create_announce_model.dart';
import 'package:attend_pro/domain/use_cases/create_announce_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'announcements_state.dart';

class AnnouncementsCubit extends Cubit<AnnouncementsState> {
  AnnouncementsCubit() : super(AnnouncementsInitial());
  static AnnouncementsCubit get(BuildContext context) =>
      BlocProvider.of(context);
  CreateAnnounceUseCase useCase = CreateAnnounceUseCase();
  CreateAnnounceModel? announceModel;
  Future<void> createAnnouncement(
      {required String content,
      required String groupId,
      required String subjectId}) async {
    emit(AnnouncementsLoading());
    try {
      announceModel = await useCase.createannouncement(
          content: content, groupId: groupId, subjectId: subjectId);
      emit(AnnouncementsSuccess());
    } on Exception catch (e) {
      emit(AnnouncementsFailure(msg: e.toString()));
    }
  }
}
