import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/bloc/auth_bloc.dart';
import 'package:login_bloc/login_screen.dart';
import 'package:login_bloc/widget/gradient_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return switch (state) {
            AuthLoading() => const Center(child: CircularProgressIndicator()),
            AuthSuccess(uid: final uid) => Center(
              child: Column(
                children: [
                  Text(uid),
                  GradientButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthLogoutRequested());
                    },
                  ),
                ],
              ),
            ),
            AuthFailure(error: final error) => Center(
              child: Column(
                children: [
                  Text('Error: $error'),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthLogoutRequested());
                    },
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            ),
            AuthInitial() => const Center(
              child: CircularProgressIndicator(),
            ), // Listener will navigate to LoginScreen
          };
        },
      ),
    );
  }
}
