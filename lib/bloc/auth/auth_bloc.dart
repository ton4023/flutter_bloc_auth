import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/auth/auth_event.dart';
import 'package:flutter_login/bloc/auth/auth_state.dart';
import 'package:flutter_login/repository/auth_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepo;
  AuthenticationBloc({required this.authRepo})
      : super(AuthenticationInitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      final bool hasToken = await authRepo.hasToken();
      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }
    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await authRepo.setToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await authRepo.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
