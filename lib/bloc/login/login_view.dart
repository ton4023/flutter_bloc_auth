import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/form_status.dart';
import 'package:flutter_login/bloc/login/login_bloc.dart';
import 'package:flutter_login/bloc/login/login_event.dart';
import 'package:flutter_login/bloc/login/login_state.dart';
import 'package:flutter_login/repository/auth_repository.dart';


class LoginView extends StatefulWidget {
  const LoginView({ Key? key }) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            LoginBloc(authRepo: context.read<AuthRepository>()),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _loginForm(),
            _singupButton(),
          ],
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _usernameField(),
              _passwordField(),
              SizedBox(
                height: 8,
              ),
              _loginButton(),
            ],
          ),
        ));
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Email : eve.holt@reqres.in',
              ),
              validator: (value) =>
                  state.isvalidUsername ? null : 'Email is too short',
              onChanged: (value) => context.read<LoginBloc>().add(
                    LoginEmailChanged(email: value),
                  ),
            ));
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => TextFormField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                icon: Icon(Icons.security),
                hintText: 'Password : cityslicka',
                suffixIcon: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: (){
                      setState(() {
                        _obscureText =! _obscureText;
                      });
                    }
                    ),
              ),
              validator: (value) =>
                  state.isValidPassword ? null : 'Password is too short',
              onChanged: (value) => context.read<LoginBloc>().add(
                    LoginPasswordChanged(password: value),
                  ),
            ));
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<LoginBloc>().add(LoginSubmited());
                }
              },
              child: Text('Login'),
            );
    });
  }

  Widget _singupButton() {
    return SafeArea(
        child: TextButton(
            onPressed: () {}, child: Text('คุณยังไม่มีบัญชี? สร้างบัญชี')));
  }
}
