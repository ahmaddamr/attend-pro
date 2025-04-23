import 'package:attend_pro/data/models/week_attendance_model.dart';
import 'package:attend_pro/data/repo/home_repo_implementation.dart';
import 'package:attend_pro/domain/repo/home_repo.dart';

class GetGroupAttendanceUseCase {
  HomeRepo repo = HomeRepoImplementation();
  Future<List<WeekAttendance>> getgroupAttendance(String id) async =>
      await repo.getGroupAttendance(id);
}
