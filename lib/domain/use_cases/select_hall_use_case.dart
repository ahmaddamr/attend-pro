import 'package:attend_pro/data/models/select_hall_model.dart';
import 'package:attend_pro/data/repo/home_repo_implementation.dart';
import 'package:attend_pro/domain/repo/home_repo.dart';

class SelectHallUseCase {
  HomeRepo repo = HomeRepoImplementation();
  Future<SelectHallModel> selectHall(String hallId,
      {required String subjectId,
      required String groupId,
      // required int weekNumber,
      required String sessionType}) async {
    return await repo.selectHall(hallId,
        subjectId: subjectId,
        groupId: groupId,
        // weekNumber: weekNumber,
        
        sessionType: sessionType);
  }
}
