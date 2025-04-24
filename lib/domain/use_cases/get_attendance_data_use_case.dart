import 'package:attend_pro/data/models/lecture_attendance_model.dart';
import 'package:attend_pro/data/repo/home_repo_implementation.dart';
import 'package:attend_pro/domain/repo/home_repo.dart';

class GetAttendanceDataUseCase {
  HomeRepo repo = HomeRepoImplementation();

  Future<LectureAttendanceModel> execute(
          String id, String date, String type) async =>
      await repo.getAttendanceData(id, date, type);
}
