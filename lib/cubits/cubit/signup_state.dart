part of 'signup_cubit.dart';

enum SignupStatus { initial, submitting, sucess, error }

class SignupState extends Equatable {
  final String email;
  final String password;
  final String name;
  final SignupStatus status;
  final User? user;

  const SignupState({
    required this.email,
    required this.password,
    required this.name,
    required this.status,
    this.user = User.empty,
  });

  factory SignupState.inital() {
    return const SignupState(
      email: '',
      password: '',
      name: '',
      user: User.empty,
      status: SignupStatus.initial,
    );
  }
  SignupState copyWith({
    String? email,
    String? password,
    String? name,
    User? user,
    SignupStatus? status,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [email, password, name, user, status];
}
