part of 'schedules_cubit.dart';

@immutable
sealed class SchedulesState {}

final class SchedulesInitial extends SchedulesState {}

final class SchedulesLoading extends SchedulesState {}

final class SchedulesSuccess extends SchedulesState {}

final class SchedulesFailure extends SchedulesState {
  final String msg;

  SchedulesFailure({required this.msg});
}

final class MySchedulesInitial extends SchedulesState {}

final class MySchedulesLoading extends SchedulesState {}

final class MySchedulesSuccess extends SchedulesState {}

final class MySchedulesFailure extends SchedulesState {
  final String msg;

  MySchedulesFailure({required this.msg});
}

final class NewAllSchedulesLoading extends SchedulesState {}

final class NewAllSchedulesSuccess extends SchedulesState {}

final class NewAllSchedulesFailure extends SchedulesState {
  final String msg;

  NewAllSchedulesFailure({required this.msg});
}
