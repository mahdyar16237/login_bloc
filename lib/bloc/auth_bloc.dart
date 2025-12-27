import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final email = event.email.trim();
      final password = event.password.trim();

      // Email validation
      if (email.isEmpty) {
        return emit(AuthFailure('Email cannot be empty!'));
      }

      if (!_isValidEmail(email)) {
        return emit(AuthFailure('Please enter a valid email address!'));
      }

      // Password validation
      if (password.isEmpty) {
        return emit(AuthFailure('Password cannot be empty!'));
      }

      if (password.length < 6) {
        return emit(AuthFailure('Password cannot be less than 6 characters!'));
      }

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // In a real app, you would call an authentication service here
      // For now, we'll just emit success
      emit(AuthSuccess(uid: '$email-$password'));
    } catch (e) {
      // Better error handling
      final errorMessage = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : 'An unexpected error occurred. Please try again.';
      return emit(AuthFailure(errorMessage));
    }
  }

  void _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // Simulate API call for logout
      await Future.delayed(const Duration(seconds: 1));

      // In a real app, you would call a logout service here
      emit(AuthInitial());
    } catch (e) {
      // Better error handling
      final errorMessage = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : 'Failed to logout. Please try again.';
      emit(AuthFailure(errorMessage));
    }
  }
}
