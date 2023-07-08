import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/bloc/auth/login/login_bloc.dart';
import 'package:login_bloc/bloc/auth/login/login_state.dart';
import 'package:login_bloc/repository/auth/login_reposittory.dart';
import 'package:login_bloc/views/auth/form_submission_status.dart';
import 'package:login_bloc/views/auth/login/widgets/form_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => LoginBloc(authRepo: context.read<LoginRepository>()),
      child: BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) =>
              previous.formStatus != current.formStatus,
          listener: (context, state) {
            final formStatus = state.formStatus;
            if (formStatus is SubmissionFailed) {
              _showSnackBar(context, formStatus.exception.toString());
            }
          },
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 200, child: Image.asset("assets/girl.jpg")),
                FormWidget(),
              ],
            ),
          ))),
    ));
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
