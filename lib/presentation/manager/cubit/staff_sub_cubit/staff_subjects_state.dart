part of 'staff_subjects_cubit.dart';

@immutable
sealed class StaffSubjectsState {}

final class StaffSubjectsInitial extends StaffSubjectsState {}

final class StaffSubjectsLoading extends StaffSubjectsState {}

final class StaffSubjectsSuccess extends StaffSubjectsState {}

final class StaffSubjectsFailure extends StaffSubjectsState {
  final String msg;
  StaffSubjectsFailure({required this.msg});
}
