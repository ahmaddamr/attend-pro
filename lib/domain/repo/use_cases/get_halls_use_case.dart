import 'package:attend_pro/data/models/get_halls_model.dart';
import 'package:attend_pro/data/repo/home_repo_implementation.dart';
import 'package:attend_pro/domain/repo/home_repo.dart';

class GetHallsUseCase {
  HomeRepo repo = HomeRepoImplementation();
  Future<List<HallDevice>> getHalls() async => await repo.getAllHalls();
}
