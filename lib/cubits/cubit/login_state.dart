part of 'login_cubit.dart';

enum LoginStatus { initial, submitting, success, error }

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;
  final User? user;

  const LoginState({
    required this.email,
    required this.password,
    required this.status,
    this.user = User.empty,
  });
  factory LoginState.initial() {
    return const LoginState(
      email: '',
      password: '',
      user: User.empty,
      status: LoginStatus.initial,
    );
  }
  @override
  List<Object?> get props => [email, password, user, status];

  LoginState copyWith({
    String? email,
    String? password,
    User? user,
    LoginStatus? status,
  }) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        user: user ?? this.user,
        status: status ?? this.status);
  }
}
