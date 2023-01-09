import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/repositories/auth_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  SignupCubit(this._authRepository, this._userRepository)
      : super(SignupState.inital());

  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: value,
        status: SignupStatus.initial,
      ),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
        status: SignupStatus.initial,
      ),
    );
  }

  void nameChanged(String value) {
    emit(
      state.copyWith(
        name: value,
        status: SignupStatus.initial,
      ),
    );
  }

  void phoneChanged(String value) {
    emit(
      state.copyWith(
        phoneNumber: value,
        status: SignupStatus.initial,
      ),
    );
  }

  Future<void> signupFormSubmitted() async {
    if (state.status == SignupStatus.submitting) return;
    emit(state.copyWith(status: SignupStatus.submitting));
    try {
      final user = await _authRepository.signup(
          email: state.email,
          password: state.password,
          name: state.name,
          phoneNumber: state.phoneNumber);
      _userRepository.addUser(user.toEntity());

      emit(state.copyWith(status: SignupStatus.sucess, user: user));
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
