class LoginState {
  final String email;
  bool get isvalidUsername => email.length > 6;

  final String password;
  bool get isValidPassword => password.length > 6;

  final LoginStatus loginStatus;

  LoginState(
      {this.email = '',
      this.password = '',
      this.loginStatus = const LoginInitial()});

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? loginStatus,
  }) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        loginStatus: loginStatus ?? this.loginStatus);
  }
}

abstract class LoginStatus {
  const LoginStatus();
}

class LoginInitial extends LoginStatus {
  const LoginInitial();
}

class LoginLoading extends LoginStatus {}

class LoginSuccess extends LoginStatus {}

class LoginFailure extends LoginStatus {
  final String error;

  LoginFailure(this.error);

  String toString() => 'LoginFailure { error: $error }';
}
