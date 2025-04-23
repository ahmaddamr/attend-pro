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
