import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_bloc/bloc/auth_bloc.dart';

void main() {
  group('AuthBloc', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] when login is successful',
      build: () => AuthBloc(),
      act: (bloc) => bloc.add(
        AuthLoginRequested(email: 'test@test.com', password: '123456'),
      ),
      wait: const Duration(seconds: 2),
      expect: () => [isA<AuthLoading>(), isA<AuthSuccess>()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] when email is empty',
      build: () => AuthBloc(),
      act: (bloc) =>
          bloc.add(AuthLoginRequested(email: '', password: '123456')),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthFailure>().having(
          (s) => s.error,
          'error',
          'Email cannot be empty!',
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] when password is less than 6 characters',
      build: () => AuthBloc(),
      act: (bloc) =>
          bloc.add(AuthLoginRequested(email: 'test@test.com', password: '123')),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthFailure>().having(
          (s) => s.error,
          'error',
          'Password cannot be less than 6 characters!',
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthInitial] when logout is requested',
      build: () => AuthBloc(),
      seed: () => AuthSuccess(uid: 'test-uid'),
      act: (bloc) => bloc.add(AuthLogoutRequested()),
      wait: const Duration(seconds: 2),
      expect: () => [isA<AuthLoading>(), isA<AuthInitial>()],
    );
  });
}
