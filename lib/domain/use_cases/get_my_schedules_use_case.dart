import 'package:attend_pro/data/models/my_schedule_model.dart';
import 'package:attend_pro/data/repo/home_repo_implementation.dart';
import 'package:attend_pro/domain/repo/home_repo.dart';

class GetMySchedulesUseCase {
  HomeRepo repo = HomeRepoImplementation();
  Future<List<ScheduleItems>> getMySchedules() async =>
      await repo.getMySchedules();
}
