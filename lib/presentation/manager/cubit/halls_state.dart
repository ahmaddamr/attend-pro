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
