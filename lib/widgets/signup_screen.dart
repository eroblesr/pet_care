import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/bloc/app/bloc/app_bloc.dart';
import 'package:pet_care/cubits/cubit/signup_cubit.dart';
import 'package:pet_care/repositories/auth_repository.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:user_repository/user_repository.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignupScreen());
  }

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late FormGroup form;
  @override
  void initState() {
    // creates a group
    form = FormGroup({
      'name': FormControl<String>(value: '', validators: [Validators.required]),
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
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocProvider<SignupCubit>(
            create: (_) => SignupCubit(
                context.read<AuthRepository>(), context.read<UserRepository>()),
            child: BlocConsumer<SignupCubit, SignupState>(
              listener: (context, state) {
                if (state.status == SignupStatus.error) {}
                if (state.status == SignupStatus.sucess) {
                  context
                      .read<AppBloc>()
                      .add(UserSignedUp(state.user ?? User.empty));
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return ReactiveForm(
                  formGroup: form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _name(context),
                      const SizedBox(height: 10),
                      _email(context),
                      const SizedBox(height: 10),
                      _password(context),
                      const SizedBox(height: 10),
                      _signup(context, state),
                    ],
                  ),
                );
              },
            )),
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
        context.read<SignupCubit>().passwordChanged(formControl.value ?? '');
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

  Widget _email(BuildContext context) {
    return ReactiveTextField(
      formControlName: 'email',
      validationMessages: {
        'required': (error) => 'The email must not be empty*',
        'email': (error) => 'The email value must be a valid email*',
      },
      onChanged: (FormControl<String> formControl) {
        context.read<SignupCubit>().emailChanged(formControl.value ?? '');
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

  Widget _name(BuildContext context) {
    return ReactiveTextField(
      formControlName: 'name',
      validationMessages: {
        'required': (error) => 'The name must not be empty*'
      },
      onChanged: (FormControl<String> formControl) {
        context.read<SignupCubit>().nameChanged(formControl.value ?? '');
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
        hintText: 'Name',
        fillColor: Colors.grey[200],
        filled: true,
      ),
    );
  }

  Widget _signup(BuildContext context, SignupState state) {
    return state.status == SignupStatus.submitting
        ? const CircularProgressIndicator()
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 40),
            ),
            onPressed: () {
              context.read<SignupCubit>().signupFormSubmitted();
            },
            child: const Text('Sign Up'),
          );
  }
}
