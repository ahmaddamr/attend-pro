import 'dart:developer';
import 'package:attend_pro/data/models/courses_model.dart';
import 'package:attend_pro/data/models/subjects_model.dart';
import 'package:attend_pro/domain/use_cases/get_courses_use_case.dart';
import 'package:attend_pro/domain/use_cases/subjects_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'subjects_state.dart';

class SubjectsCubit extends Cubit<SubjectsState> {
  SubjectsCubit() : super(SubjectsInitial());
  static SubjectsCubit get(BuildContext context) => BlocProvider.of(context);
  List<SubjectData> subjects = [];
  List<CourseSubject> courses = [];
  SubjectsUseCase useCase = SubjectsUseCase();
  GetCoursesUseCase coursesUseCase = GetCoursesUseCase();
  Future<void> getSubjects() async {
    emit(SubjectsLoading());
    try {
      subjects = await useCase.getSubjects();
      emit(SubjectsSuccess());
    } catch (e, stackTrace) {
      log('❌ Error in getHalls Cubit: $e');
      log('📍 Stack trace: $stackTrace');
      emit(
        SubjectsFailure(msg: e.toString()),
      );
    }
  }

  Future<void> getCourses() async {
    emit(CoursesLoading());
    try {
      courses = await coursesUseCase.getCourses();
      log(courses.toString());
      emit(CoursesSuccess());
    } catch (e, stackTrace) {
      log('❌ Error in getCourses Cubit: $e');
      log('📍 Stack trace: $stackTrace');
      emit(
        CoursesFailure(
          msg: e.toString(),
        ),
      );
    }
  }
}
