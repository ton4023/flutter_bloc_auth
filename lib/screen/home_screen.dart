import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/auth/auth_bloc.dart';
import 'package:flutter_login/bloc/auth/auth_event.dart';
import 'package:flutter_login/bloc/auth/auth_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<AuthenticationBloc>(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Row(
              children: [
                logoutButton(),
              ],
            )
          ],
        ),
        body: Container(
          child: Center(
            child: Text('Wellcome to Main Screen'),
          ),
        ),
      ),
    );
  }

  Widget logoutButton() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) => IconButton(
        icon: Icon(Icons.logout),
        onPressed: () {
          context.read<AuthenticationBloc>().add(LoggedOut());
        },
      ),
    );
  }
}
