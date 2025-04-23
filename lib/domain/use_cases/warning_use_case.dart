import 'package:attend_pro/data/models/warning_model.dart';
import 'package:attend_pro/data/repo/home_repo_implementation.dart';
import 'package:attend_pro/domain/repo/home_repo.dart';

class WarningUseCase {
  HomeRepo repo = HomeRepoImplementation();
  Future<WarningModel> getWarnings() async => await repo.getWarnings();
}
