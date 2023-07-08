import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/bloc/auth/login/login_bloc.dart';
import 'package:login_bloc/bloc/auth/login/login_event.dart';
import 'package:login_bloc/bloc/auth/login/login_state.dart';
import 'package:login_bloc/views/auth/form_submission_status.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key, required this.formkey}) : super(key: key);

  final dynamic formkey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    context.read<LoginBloc>().add(const LoginSubmitted());
                  }
                },
                child: const Text('Login'),
              );
      },
    );
  }
}
