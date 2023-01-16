import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/bloc/app/bloc/app_bloc.dart';
import 'package:pet_care/cubits/cubit/signup_cubit.dart';
import 'package:pet_care/repositories/auth_repository.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter/services.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

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
    // phone regex
    final phonePattern = r'^(?:[+0]9)?[0-9]{10}$';
    // creates a group
    form = FormGroup({
      'name': FormControl<String>(value: '', validators: [Validators.required]),
      'phoneNumber': FormControl<String>(
          validators: [Validators.required, Validators.pattern(phonePattern)]),
      'email': FormControl<String>(
          value: '', validators: [Validators.required, Validators.email]),
      'password': FormControl<String>(
          validators: [Validators.required, Validators.minLength(8)]),
      'passwordConfirmation': FormControl<String>(),
    }, validators: [
      _mustMatch('password', 'passwordConfirmation')
    ]);
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _name(context),
                        const SizedBox(height: 10),
                        _phoneNumber(context),
                        const SizedBox(height: 10),
                        _email(context),
                        const SizedBox(height: 10),
                        _password(context),
                        const SizedBox(height: 10),
                        _passwordConfirmation(context),
                        const SizedBox(height: 10),
                        _signup(context, state, form),
                      ],
                    ),
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

  Widget _passwordConfirmation(BuildContext context) {
    return ReactiveTextField(
      formControlName: 'passwordConfirmation',
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
        hintText: 'Password Confirmation',
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

  Widget _phoneNumber(BuildContext context) {
    return ReactiveTextField(
      formControlName: 'phoneNumber',
      validationMessages: {'required': (error) => 'incorrect pattern*'},
      onChanged: (FormControl<String> formControl) {
        context.read<SignupCubit>().phoneChanged(formControl.value ?? '');
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
        hintText: 'phone Number',
        fillColor: Colors.grey[200],
        filled: true,
      ),
    );
  }

  Timer scheduleTimeout([int milliseconds = 10000]) =>
      Timer(Duration(milliseconds: milliseconds), handleTimeout);
  void handleTimeout() {
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'On Snap!',
        message: 'Time is out, try again!',

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.failure,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
    // callback function
    // Do some work.
  }

  Widget _signup(BuildContext context, SignupState state, FormGroup form) {
    return state.status == SignupStatus.submitting
        ? const CircularProgressIndicator()
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 40),
            ),
            onPressed: () {
              if (form.valid) {
                //Flutter timer
                scheduleTimeout(2 * 1000); // 5 seconds.
                context.read<SignupCubit>().signupFormSubmitted();
              } else {
                final snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'On Snap!',
                    message: 'Please fill the missing fields!',

                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    contentType: ContentType.failure,
                  ),
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              }
              ;
            },
            child: const Text('Sign Up'),
          );
  }
}

ValidatorFunction _mustMatch(String controlName, String matchingControlName) {
  return (AbstractControl<dynamic> control) {
    final form = control as FormGroup;

    final formControl = form.control(controlName);
    final matchingFormControl = form.control(matchingControlName);

    if (formControl.value != matchingFormControl.value) {
      matchingFormControl.setErrors({'mustMatch': true});

      // force messages to show up as soon as possible
      matchingFormControl.markAsTouched();
    } else {
      matchingFormControl.removeError('mustMatch');
    }

    return null;
  };
}
