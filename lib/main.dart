
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/auth/auth_bloc.dart';
import 'package:flutter_login/bloc/auth/auth_event.dart';
import 'package:flutter_login/bloc/auth/auth_state.dart';
import 'package:flutter_login/bloc_observe.dart';
import 'package:flutter_login/repository/auth_repository.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _authRepo = AuthRepository();
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  testView(),
    );
  }

  Widget testView() {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            AuthenticationBloc(authRepository: _authRepo)..add(AppStarted()),
        child: BlocBuilder<AuthenticationBloc,AuthenticationState>(
          builder: (context,state) { 
            return Text('$state'); 
          }
        ),
      ),
    );
  }
}
