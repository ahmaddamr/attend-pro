import 'package:attend_pro/data/models/end_check_out_model.dart';
import 'package:attend_pro/data/repo/home_repo_implementation.dart';
import 'package:attend_pro/domain/repo/home_repo.dart';

class EndCheckOutUseCase {
  HomeRepo repo = HomeRepoImplementation();

  Future<EndCheckOutModel> endCheckOut(String id) async {
    return await repo.endCheckOut(id);
  }
}
