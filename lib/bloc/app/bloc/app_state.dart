part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

enum Screen { none, home, petDetails }

class AppState extends Equatable {
  final Screen screen;
  final AppStatus status;
  final User user;

  const AppState._({
    required this.screen,
    required this.status,
    this.user = User.empty,
  });

  const AppState.authenticated(User user, Screen screen)
      : this._(
          status: AppStatus.authenticated,
          screen: screen,
          user: user,
        );
  const AppState.unauthenticated()
      : this._(status: AppStatus.unauthenticated, screen: Screen.none);

  @override
  List<Object> get props => [user, status, screen];
}
