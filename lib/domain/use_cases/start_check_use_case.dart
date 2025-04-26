import 'package:attend_pro/data/models/start_check_model.dart';
import 'package:attend_pro/data/repo/home_repo_implementation.dart';
import 'package:attend_pro/domain/repo/home_repo.dart';

class StartCheckUseCase {
  HomeRepo repo = HomeRepoImplementation();
  Future<StartCheckModel> startCheck(id) async {
    return await repo.startCheck(id);
  }
}
