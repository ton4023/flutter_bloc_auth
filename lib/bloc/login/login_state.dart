
import 'package:flutter_login/bloc/form_status.dart';

class LoginState {
  final String email;
  bool get isvalidUsername => email.length > 6;

  final String password;
  bool get isValidPassword => password.length > 6;

  final FormSubmisstionStatus formStatus;

  LoginState({this.email = '', this.password = '', this.formStatus = const InitialFormStatus()});

  LoginState copyWith({
    String? email,
    String? password, 
    FormSubmisstionStatus? formStatus,
  }) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus );
  }
}