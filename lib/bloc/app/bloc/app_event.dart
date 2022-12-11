part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutRequest extends AppEvent {}

class AppUserChanged extends AppEvent {
  final User user;

  const AppUserChanged(this.user);

  @override
  List<Object> get props => [user];
}

class UserSignedUp extends AppEvent {
  final User user;

  const UserSignedUp(this.user);

  @override
  List<Object> get props => [user];
}
