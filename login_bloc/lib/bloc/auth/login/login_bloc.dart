import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/bloc/auth/login/login_event.dart';
import 'package:login_bloc/bloc/auth/login/login_state.dart';
import 'package:login_bloc/repository/auth/login_reposittory.dart';
import 'package:login_bloc/views/auth/form_submission_status.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository? authRepo;

  LoginBloc({this.authRepo}) : super(const LoginState()) {
    on<LoginEvent>(
      (event, emit) async {
        await mapEventToState(event, emit);
      },
    );
  }

  Future mapEventToState(LoginEvent event, Emitter<LoginState> emit) async {
    if (event is LoginUsernameChanged) {
      emit(state.copyWith(username: event.username));
    } else if (event is LoginPasswordChanged) {
      emit(state.copyWith(password: event.password));
    } else if (event is LoginSubmitted) {
      emit(state.copyWith(formStatus: FormSubmitting()));
      try {
        await authRepo!.login();
        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(exception: e)));
      }
    }
  }
}
