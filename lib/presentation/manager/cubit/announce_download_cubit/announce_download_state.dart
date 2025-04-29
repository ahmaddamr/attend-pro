// attendance_download_state.dart

import 'dart:io';

abstract class AttendanceDownloadState {}

class AttendanceDownloadInitial extends AttendanceDownloadState {}

class AttendanceDownloadLoading extends AttendanceDownloadState {}

class AttendanceDownloadSuccess extends AttendanceDownloadState {
  final File file;

  AttendanceDownloadSuccess(this.file);
}

class AttendanceDownloadError extends AttendanceDownloadState {
  final String errorMessage;

  AttendanceDownloadError(this.errorMessage);
}
