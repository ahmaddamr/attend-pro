// attendance_download_cubit.dart

import 'package:attend_pro/core/services/download_pdf/download_attendance.dart';
import 'package:attend_pro/presentation/manager/cubit/announce_download_cubit/announce_download_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

class AttendanceDownloadCubit extends Cubit<AttendanceDownloadState> {
  final AttendanceRepository repository;

  AttendanceDownloadCubit(this.repository) : super(AttendanceDownloadInitial());

  Future<void> downloadWeeklyAttendance({
    required String groupId,
    required int week,
  }) async {
    emit(AttendanceDownloadLoading());

    try {
      final file = await repository.downloadWeeklyAttendance(
        groupId: groupId,
        week: week,
      );

      if (file != null) {
        emit(AttendanceDownloadSuccess(file));
      } else {
        emit(AttendanceDownloadError('Failed to download the PDF file.'));
      }
    } catch (e) {
      emit(AttendanceDownloadError('Error: $e'));
    }
  }

  Future<void> openDownloadedFile(File file) async {
    try {
      await repository.openPdfFile(file);
    } catch (e) {
      emit(AttendanceDownloadError('Failed to open file: $e'));
    }
  }
}
