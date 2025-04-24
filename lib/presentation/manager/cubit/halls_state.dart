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
