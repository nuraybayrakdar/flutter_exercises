import 'package:flutter/material.dart';
import 'package:login_bloc/views/auth/login/widgets/login_button.dart';
import 'package:login_bloc/views/auth/login/widgets/passwword_textfield.dart';
import 'package:login_bloc/views/auth/login/widgets/username_textfield.dart';

class FormWidget extends StatelessWidget {
  FormWidget({super.key});
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            const UsernameTextfield(),
            const PasswordTextfield(),
            LoginButton(
              formkey: _formKey,
            )
          ],
        ));
  }
}
