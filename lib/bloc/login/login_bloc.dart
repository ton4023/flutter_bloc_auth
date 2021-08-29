import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/auth/auth_bloc.dart';
import 'package:flutter_login/bloc/auth/auth_event.dart';
import 'package:flutter_login/repository/auth_repository.dart';
import 'package:flutter_login/bloc/login/login_event.dart';
import 'package:flutter_login/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    required this.authenticationBloc,
    required this.authRepository,
  }) : super(LoginState());

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
        //final token = await authRepository.login('eve.holt@reqres.in', 'cityslicka');
        final token = await authRepository.login(state.email, state.password);
        authenticationBloc..add(LoggedIn(token: token));
        yield state.copyWith(loginStatus: LoginSuccess());
      } catch (e) {
        yield state.copyWith(loginStatus: LoginFailure(e.toString()));
      }
    }
  }
}
