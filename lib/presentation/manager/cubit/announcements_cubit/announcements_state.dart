part of 'announcements_cubit.dart';

@immutable
sealed class AnnouncementsState {}

final class AnnouncementsInitial extends AnnouncementsState {}

final class AnnouncementsLoading extends AnnouncementsState {}

final class AnnouncementsSuccess extends AnnouncementsState {}

final class AnnouncementsFailure extends AnnouncementsState {
  final String msg;

  AnnouncementsFailure({required this.msg});
}
