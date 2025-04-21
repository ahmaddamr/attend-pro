import 'package:attend_pro/data/models/all_schedules_model.dart';
import 'package:attend_pro/data/repo/home_repo_implementation.dart';
import 'package:attend_pro/domain/repo/home_repo.dart';

class GetAllSchedulesUseCase {
  HomeRepo repo = HomeRepoImplementation();
  Future<List<ScheduleGroup>> getAllSchedules() async =>
      await repo.getAllSchedules();
}
