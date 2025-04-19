import 'package:attend_pro/data/models/subjects_model.dart';
import 'package:attend_pro/data/repo/home_repo_implementation.dart';
import 'package:attend_pro/domain/repo/home_repo.dart';

class SubjectsUseCase {
  HomeRepo repo = HomeRepoImplementation();

  Future<List<Subject>> getSubjects() async => await repo.getAllSubjects();
}
