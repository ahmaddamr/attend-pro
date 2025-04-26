import 'package:attend_pro/data/models/start_check_out_model.dart';
import 'package:attend_pro/data/repo/home_repo_implementation.dart';
import 'package:attend_pro/domain/repo/home_repo.dart';

class StartCheckOutUseCase {
  HomeRepo repo = HomeRepoImplementation();

  Future<StartCheckOutModel> startCheckOut(String id) async {
    return await repo.StartCheckOut(id);
  }
}
