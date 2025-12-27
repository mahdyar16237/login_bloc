import 'package:flutter_test/flutter_test.dart';
import 'package:login_bloc/bloc/auth_bloc.dart';

void main() {
  test('AuthInitial should be a AuthState', () {
    expect(AuthInitial(), isA<AuthState>());
  });

  test('AuthLoading should be a AuthState', () {
    expect(AuthLoading(), isA<AuthState>());
  });

  test('AuthSuccess holds correct uid', () {
    const uid = 'test-uid';
    final state = AuthSuccess(uid: uid);

    expect(state.uid, uid);
  });

  test('AuthFailure holds correct error message', () {
    const error = 'Something went wrong';
    final state = AuthFailure(error);

    expect(state.error, error);
  });
}
