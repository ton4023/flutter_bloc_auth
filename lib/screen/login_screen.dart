import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/auth/auth_bloc.dart';
import 'package:flutter_login/bloc/login/login_bloc.dart';
import 'package:flutter_login/bloc/login/login_event.dart';
import 'package:flutter_login/bloc/login/login_state.dart';
import 'package:flutter_login/repository/auth_repository.dart';
import 'package:google_fonts/google_fonts.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authRepostiry = AuthRepository();
  
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          authRepository: _authRepostiry),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade400,
              Colors.blue.shade500
            ]
          )
        ),
        child: Stack(
          children: [
            _loginForm(),
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
              SizedBox(height: 50),
              _title(),
              SizedBox(height: 40),
              _usernameField(),
              SizedBox(height: 20),
              _passwordField(),
              SizedBox(
                height: 40,
              ),
              _loginButton(),
            ],
          ),
        ));
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'L',
        style: GoogleFonts.portLligatSans(
          textStyle: Theme.of(context).textTheme.headline4,
          fontSize: 50,
          fontWeight: FontWeight.w700,
          color:Colors.amberAccent
        ),
        children: [
          TextSpan(
            text: 'og',
            style: TextStyle(
              color: Colors.black, 
              fontSize: 40,
              fontWeight:FontWeight.bold),
          ),
          TextSpan(
            text: 'in',
            style: TextStyle(
              color: Colors.white, 
              fontSize: 40
              ),
          )
        ]
      )
    );
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Email : eve.holt@reqres.in',
              ),
              // validator: (value) =>
              //     state.isvalidUsername ? null : 'Email is too short',
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
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    }),
              ),
              // validator: (value) =>
              //     state.isValidPassword ? null : 'Password is too short',
              onChanged: (value) => context.read<LoginBloc>().add(
                    LoginPasswordChanged(password: value),
                  ),
            ));
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.loginStatus is LoginLoading
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

}
