import 'dart:io';

import 'package:attend_pro/data/models/students_signup_model.dart';
import 'package:attend_pro/domain/use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  UseCase useCase = UseCase();
  final email = TextEditingController();
  final uniEmail = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phone = TextEditingController();
  File? img;
  StudentsSignUpModel? model;

  Future<void> studentSignUp() async {
    emit(AuthLoading());
    try {
      model = await useCase.studentSignUp(
          firstName: firstName.text,
          lastName: lastName.text,
          email: email.text,
          university_email: uniEmail.text,
          password: password.text,
          phoneNumber: phone.text,
          image: img!);
      if (model?.user != null) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure(msg: model?.message ?? "Something went wrong"));
      }
    } on Exception catch (e) {
      emit(
        AuthFailure(msg: e.toString()),
      );
    }
  }
}
