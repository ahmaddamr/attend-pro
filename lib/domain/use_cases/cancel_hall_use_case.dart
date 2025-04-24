import 'package:attend_pro/data/models/cancel_hall_model.dart';
import 'package:attend_pro/data/repo/home_repo_implementation.dart';
import 'package:attend_pro/domain/repo/home_repo.dart';

class CancelHallUseCase {
  HomeRepo repo = HomeRepoImplementation();

  Future<CancelHallModel> cancelHall(String id) async {
    return await repo.cancelHall(id);
  }
}
