import 'package:attend_pro/domain/repo/home_repo.dart';

import '../../data/models/courses_model.dart';
import '../../data/repo/home_repo_implementation.dart';

class GetCoursesUseCase {
  HomeRepo repo = HomeRepoImplementation();

  Future<List<CourseSubject>> getCourses() async => await repo.getCourses();
}
