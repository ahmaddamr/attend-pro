import 'package:attend_pro/data/models/staff_subjects_model.dart';
import 'package:attend_pro/data/repo/home_repo_implementation.dart';
import 'package:attend_pro/domain/repo/home_repo.dart';

class StaffSubjectsUseCase {
  HomeRepo repo = HomeRepoImplementation();

  Future<List<StaffSubjectData>> getStaffSubjects() async {
    return await repo.getStaffSubjects();
  }
}
