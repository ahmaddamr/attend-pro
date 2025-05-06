import 'package:attend_pro/data/repo/home_repo_implementation.dart';
import 'package:attend_pro/domain/repo/home_repo.dart';

import '../../data/models/new_all_schedules_model.dart';

class NewAllSchedulesUseCase {
  HomeRepo repo = HomeRepoImplementation();

  Future<NewAllSchedulesModel> getAllNewSchedules() async {
    return await repo.getNewAllSchedules();
  }
}
