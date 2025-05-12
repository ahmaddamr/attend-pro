part of 'pending_cubit.dart';

@immutable
sealed class PendingState {}

final class PendingInitial extends PendingState {}

final class AcceptPendingLoading extends PendingState {}

final class AcceptPendingSuccess extends PendingState {}

final class AcceptPendingFailure extends PendingState {
  final String msg;
  AcceptPendingFailure(this.msg);
}
