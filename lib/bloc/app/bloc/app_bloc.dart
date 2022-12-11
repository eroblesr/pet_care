import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_care/repositories/auth_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository; // necesito encontrar repository
  final UserRepository _userRepository;
  // StreamSubscription<User>? _userSubscription;

  AppBloc(
      {required AuthRepository authRepository,
      required UserRepository userRepository})
      : _authRepository = authRepository,
        _userRepository = userRepository,
        super(
          authRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequest>(_onLogoutRequest);
    on<UserSignedUp>(_onUserSignedUp);
  }
  void _onUserSignedUp(
    UserSignedUp event,
    Emitter<AppState> emit,
  ) {
    emit(event.user.isNotEmpty
        ? AppState.authenticated(event.user)
        : const AppState.unauthenticated());
  }

  void _onUserChanged(
    AppUserChanged event,
    Emitter<AppState> emit,
  ) {
    emit(event.user.isNotEmpty
        ? AppState.authenticated(event.user)
        : const AppState.unauthenticated());
  }

  void _onLogoutRequest(
    AppLogoutRequest event,
    Emitter<AppState> emit,
  ) {
    unawaited(_authRepository.logOut());
  }
}
