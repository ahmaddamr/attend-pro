import 'package:flutter/material.dart';

@immutable
sealed class AttendanceState {}

final class AttendanceInitial extends AttendanceState {}

final class AttendanceLoading extends AttendanceState {}

final class AttendanceSuccess extends AttendanceState {}

final class AttendanceError extends AttendanceState {
  final String msg;

  AttendanceError({required this.msg});
}

final class StudentAttendanceLoading extends AttendanceState {}

final class StudentAttendanceSuccess extends AttendanceState {}

final class StudentAttendanceFailure extends AttendanceState {
  final String msg;

  StudentAttendanceFailure({required this.msg});
}

final class WarningLoading extends AttendanceState {}

final class WarningSuccess extends AttendanceState {}

final class WarningFailure extends AttendanceState {
  final String msg;

  WarningFailure({required this.msg});
}

final class SessionDataLoading extends AttendanceState {}

final class SessionDataSuccess extends AttendanceState {}

final class SessionDataFailure extends AttendanceState {
  final String msg;

  SessionDataFailure({required this.msg});
}
