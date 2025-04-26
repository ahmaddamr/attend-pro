import 'package:attend_pro/data/models/end_check_model.dart';
import 'package:attend_pro/data/repo/home_repo_implementation.dart';
import 'package:attend_pro/domain/repo/home_repo.dart';

class EndCheckUseCase {
  HomeRepo repo = HomeRepoImplementation();

  Future<EndCheckModel> endCheck(String id) async => await repo.endCheck(id);
}
