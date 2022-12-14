import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:pet_care/bloc/app/bloc/app_bloc.dart';
import 'package:pet_care/repositories/auth_repository.dart';
import 'package:pet_care/widgets/signup_screen.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:user_repository/user_repository.dart';

import '../cubits/cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static Page page() => const MaterialPage<void>(child: LoginPage());

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late FormGroup form;
  @override
  void initState() {
    //creates group
    form = FormGroup({
      'email': FormControl<String>(
          value: '', validators: [Validators.required, Validators.email]),
      'password': FormControl<String>(
          validators: [Validators.required, Validators.minLength(8)]),
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log In')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocProvider<LoginCubit>(
            create: (_) => LoginCubit(
                  context.read<AuthRepository>(),
                  context.read<UserRepository>(),
                ),
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state.status == LoginStatus.error) {}
                if (state.status == LoginStatus.success) {
                  context
                      .read<AppBloc>()
                      .add(UserLoggedIn(state.user ?? User.empty));
                }
              },
              builder: (context, state) {
                return ReactiveForm(
                  formGroup: form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _email(context),
                      const SizedBox(height: 10),
                      _password(context),
                      const SizedBox(height: 10),
                      _LoginButton(context, state),
                      const SizedBox(height: 8),
                      _SignupButton(),
                    ],
                  ),
                );
              },
            )),
      ),
    );
  }
}

Widget _email(BuildContext context) {
  return ReactiveTextField(
    formControlName: 'email',
    validationMessages: {
      'required': (error) => 'The email must not be empty*',
      'email': (error) => 'The email value must be a valid email*',
    },
    onChanged: (FormControl<String> formControl) {
      context.read<LoginCubit>().emailChanged(formControl.value ?? '');
    },
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.deepPurple),
        borderRadius: BorderRadius.circular(12),
      ),
      hintText: 'Email',
      fillColor: Colors.grey[200],
      filled: true,
    ),
  );
}

Widget _password(BuildContext context) {
  return ReactiveTextField(
    formControlName: 'password',
    obscureText: true,
    validationMessages: {
      'required': (error) => 'The password must not be empty*',
      'minLength': (error) => 'The password must have at least 8 characters*'
    },
    onChanged: (FormControl<String> formControl) {
      context.read<LoginCubit>().passwordChanged(formControl.value ?? '');
    },
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.deepPurple),
        borderRadius: BorderRadius.circular(12),
      ),
      hintText: 'Password',
      fillColor: Colors.grey[200],
      filled: true,
    ),
  );
}

Widget _LoginButton(BuildContext context, LoginState state) {
  return state.status == LoginStatus.submitting
      ? const CircularProgressIndicator()
      : ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(200, 40),
          ),
          onPressed: () {
            context.read<LoginCubit>().loginFormSubmitted();
          },
          child: const Text('Log In'),
        );
}

class _SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        fixedSize: const Size(200, 40),
      ),
      onPressed: () => Navigator.of(context).push<void>(SignupScreen.route()),
      child: const Text(
        'Sign Up',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}
