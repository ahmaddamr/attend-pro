import 'package:attend_pro/data/models/create_announce_model.dart';
import 'package:attend_pro/data/models/group_announcements_model.dart';
import 'package:attend_pro/domain/use_cases/create_announce_use_case.dart';
import 'package:attend_pro/domain/use_cases/get_group_announcement_use_case.dart';
import 'package:attend_pro/domain/use_cases/get_student_announcment_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'announcements_state.dart';

class AnnouncementsCubit extends Cubit<AnnouncementsState> {
  AnnouncementsCubit() : super(AnnouncementsInitial());
  static AnnouncementsCubit get(BuildContext context) =>
      BlocProvider.of(context);
  CreateAnnounceUseCase useCase = CreateAnnounceUseCase();
  GetGroupAnnouncementUseCase getAnnouncement = GetGroupAnnouncementUseCase();
  GetStudentAnnouncmentUseCase studentAnnouncmentUseCase =
      GetStudentAnnouncmentUseCase();
  CreateAnnounceModel? announceModel;
  List<GroupAnnouncementModel> announcements = [];
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

  Future<void> getGroupAnnouncements(String groupId) async {
    emit(GetAnnouncementsLoading());
    try {
      announcements = await getAnnouncement.getgroupAnnouncement(groupId);
      emit(GetAnnouncementsSuccess());
    } catch (e) {
      emit(GetAnnouncementsFailure(msg: e.toString()));
    }
  }

  Future<void> getStudentAnnouncements() async {
    emit(GetAnnouncementsLoading());
    try {
      announcements = await studentAnnouncmentUseCase.getStudentAnnouncement();
      emit(GetAnnouncementsSuccess());
    } catch (e) {
      emit(GetAnnouncementsFailure(msg: e.toString()));
    }
  }
}
