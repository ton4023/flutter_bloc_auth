import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/auth/auth_bloc.dart';
import 'package:flutter_login/bloc/auth/auth_event.dart';
import 'package:flutter_login/repository/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  final AuthenticationBloc authBloc;

  LoginBloc({required this.authBloc, required this.authRepo, }) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEmailChanged) {
      yield state.copyWith(email: event.email);
    }
    if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);
    }
    if (event is LoginSubmited) {
      yield state.copyWith(loginStatus: LoginLoading());

      try {
        final token = await authRepo.login(state.email, state.password);
        authBloc.add(LoggedIn(token: token));
        yield state.copyWith(loginStatus: LoginSuccess());
      } catch (e) {
        yield state.copyWith(loginStatus: LoginFailure(e.toString()));
        print(e.toString());
      }
    }
  }
}
