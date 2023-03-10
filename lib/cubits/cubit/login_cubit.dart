import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/repositories/auth_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  LoginCubit(this._authRepository, this._userRepository)
      : super(LoginState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: LoginStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: LoginStatus.initial));
  }

  Future<void> loginFormSubmitted() async {
    if (state.status == LoginStatus.submitting) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      final user = await _authRepository.logInWithEmailAndPassword(
          email: state.email, password: state.password);
      _userRepository.addUser(user.toEntity());

      emit(state.copyWith(status: LoginStatus.success, user: user));
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
