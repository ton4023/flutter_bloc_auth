import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/repository/auth_repository.dart';
import 'screen/login_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: RepositoryProvider(
      create: (context) => AuthRepository(),
      child: LoginView(),
    ),
  );
  }
  
}