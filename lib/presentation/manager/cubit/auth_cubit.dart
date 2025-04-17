import 'dart:io';
import 'package:attend_pro/data/models/students_signup_model.dart';
import 'package:attend_pro/domain/use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/login_model.dart';
import '../../../data/models/logout_model.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  UseCase useCase = UseCase();

  final email = TextEditingController();
  final uniEmail = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phone = TextEditingController();

  File? img;
  StudentsSignUpModel? model;
  LoginModel? loginModel;
  LogoutModel? logoutModel;

  Future<void> studentSignUp() async {
    emit(AuthLoading());

    if (img == null) {
      emit(AuthFailure(msg: "Please select a profile photo."));
      return;
    }

    try {
      model = await useCase.studentSignUp(
        firstName: firstName.text,
        lastName: lastName.text,
        email: email.text,
        university_email: uniEmail.text,
        password: password.text,
        phoneNumber: phone.text,
        image: img!,
      );

      if (model != null && model!.user != null) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure(msg: model?.message ?? "Registration failed."));
      }
    } on Exception catch (e) {
      emit(AuthFailure(msg: e.toString()));
    } catch (e) {
      emit(AuthFailure(msg: "Unexpected error: $e"));
    }
  }

  Future<void> login() async {
    emit(LoginLoading());
    try {
      LoginModel loginModel =
          await useCase.login(email: email.text, password: password.text);

      if (loginModel.user?.role == 'student') {
        emit(LoginStudentSuccess());
      } else {
        emit(LoginFailure(msg: 'You are not a student.'));
      }
    } catch (e) {
      emit(
        LoginFailure(
          msg: e.toString(),
        ),
      );
    }
  }

  Future<void> logout() async {
    emit(LogoutLoading());

    LogoutModel logoutModel = await useCase.logout();

    emit(LogoutSuccess());
  }
}
