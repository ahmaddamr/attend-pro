part of 'groups_cubit.dart';

@immutable
sealed class GroupsState {}

final class GroupsInitial extends GroupsState {}

final class GroupsLoading extends GroupsState {}

final class GroupsSuccess extends GroupsState {}

final class GroupsFailure extends GroupsState {
  final String msg;

  GroupsFailure({required this.msg});
}
