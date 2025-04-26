part of 'halls_cubit.dart';

@immutable
sealed class HallsState {}

final class HallsInitial extends HallsState {}

final class HallsLoading extends HallsState {}

final class HallsSuccess extends HallsState {}

final class HallsError extends HallsState {
  final String msg;

  HallsError({required this.msg});
}

final class SelectHallsLoading extends HallsState {}

final class SelectHallsSuccess extends HallsState {}

final class SelectHallsFailure extends HallsState {
  final String msg;

  SelectHallsFailure({required this.msg});
}

final class CancelHallsLoading extends HallsState {}

final class CancelHallsSuccess extends HallsState {}

final class CancelHallsFailure extends HallsState {
  final String msg;

  CancelHallsFailure({required this.msg});
}

final class StartCheckLoading extends HallsState {}

final class StartCheckSuccess extends HallsState {}

final class StartCheckFailure extends HallsState {
  final String msg;

  StartCheckFailure({required this.msg});
}

final class EndCheckLoading extends HallsState {}

final class EndCheckSuccess extends HallsState {}

final class EndCheckFailure extends HallsState {
  final String msg;

  EndCheckFailure({required this.msg});
}

final class StartCheckOutLoading extends HallsState {}

final class StartCheckOutSuccess extends HallsState {}

final class StartCheckOutFailure extends HallsState {
  final String msg;

  StartCheckOutFailure({required this.msg});
}

final class EndCheckOutLoading extends HallsState {}

final class EndCheckOutSuccess extends HallsState {}

final class EndCheckOutFailure extends HallsState {
  final String msg;

  EndCheckOutFailure({required this.msg});
}
