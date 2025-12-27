import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/app_bloc_observer.dart';
import 'package:login_bloc/bloc/auth_bloc.dart';
import 'package:login_bloc/login_screen.dart';
import 'package:login_bloc/colors.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: colors.backgroundColor,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
