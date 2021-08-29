import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/auth/auth_bloc.dart';
import 'package:flutter_login/bloc/auth/auth_event.dart';
import 'package:flutter_login/bloc/auth/auth_state.dart';
import 'package:flutter_login/bloc_observe.dart';
import 'package:flutter_login/repository/auth_repository.dart';
import 'package:flutter_login/screen/home_screen.dart';
import 'package:flutter_login/screen/loading_screen.dart';
import 'package:flutter_login/screen/login_screen.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _authRepostiry = AuthRepository();
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: blocView(),
    );
  }

  Widget blocView() {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthenticationBloc(authRepository: _authRepostiry)
          ..add(AppStarted()),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state is AuthenticationUnauthenticated) {
            return LoginScreen();
          }
          if (state is AuthenticationAuthenticated) {
            return HomeScreen();
          }
          if (state is AuthenticationLoading) {
            return LoadingScreen();
          }
          return Container();
        }),
      ),
    );
  }
}
