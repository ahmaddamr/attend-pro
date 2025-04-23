import 'package:attend_pro/data/models/student_attendance_model.dart';
import 'package:attend_pro/data/repo/home_repo_implementation.dart';
import 'package:attend_pro/domain/repo/home_repo.dart';

class StudentAttendanceUseCase {
  HomeRepo repo = HomeRepoImplementation();

  Future<List<AttendanceData>> getStudentAttendance(String id) async {
    return await repo.getStudentAttendance(id);
  }
}
