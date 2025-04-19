part of 'subjects_cubit.dart';

@immutable
sealed class SubjectsState {}

final class SubjectsInitial extends SubjectsState {}

final class SubjectsLoading extends SubjectsState {}

final class SubjectsSuccess extends SubjectsState {}

final class SubjectsFailure extends SubjectsState {
  final String msg;

  SubjectsFailure({required this.msg});
}

final class CoursesInitial extends SubjectsState {}

final class CoursesLoading extends SubjectsState {}

final class CoursesSuccess extends SubjectsState {}

final class CoursesFailure extends SubjectsState {
  final String msg;

  CoursesFailure({required this.msg});
}
