import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_bloc/bloc/auth_bloc.dart';
import 'package:login_bloc/login_screen.dart';

void main() {
  group('LoginScreen Widget Tests', () {
    Widget createTestWidget(AuthBloc authBloc) {
      return MaterialApp(
        home: BlocProvider<AuthBloc>.value(
          value: authBloc,
          child: const LoginScreen(),
        ),
      );
    }

    testWidgets('displays sign in text', (WidgetTester tester) async {
      final authBloc = AuthBloc();

      await tester.pumpWidget(createTestWidget(authBloc));
      await tester.pump();

      expect(find.text('Sign in.'), findsOneWidget);

      authBloc.close();
    });

    testWidgets('displays email and password fields', (
      WidgetTester tester,
    ) async {
      final authBloc = AuthBloc();

      await tester.pumpWidget(createTestWidget(authBloc));
      await tester.pump();

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));

      authBloc.close();
    });

    testWidgets('displays social login buttons', (WidgetTester tester) async {
      final authBloc = AuthBloc();

      await tester.pumpWidget(createTestWidget(authBloc));
      await tester.pump();

      expect(find.text('Continue with Google'), findsOneWidget);
      expect(find.text('Continue with Facebook'), findsOneWidget);

      authBloc.close();
    });

    testWidgets('displays sign in button', (WidgetTester tester) async {
      final authBloc = AuthBloc();

      await tester.pumpWidget(createTestWidget(authBloc));
      await tester.pump();

      expect(find.text('Sign in'), findsOneWidget);

      authBloc.close();
    });

    testWidgets('shows loading indicator when state is AuthLoading', (
      WidgetTester tester,
    ) async {
      final authBloc = AuthBloc();

      await tester.pumpWidget(createTestWidget(authBloc));
      await tester.pump();

      // Verify initial state shows form
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Sign in.'), findsOneWidget);

      // Trigger loading state
      authBloc.add(
        AuthLoginRequested(email: 'test@example.com', password: 'password123'),
      );

      // Wait for the state to propagate and UI to rebuild
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Now loading indicator should be visible
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Flush all pending timers to avoid test failure
      await tester.pump(const Duration(seconds: 2));

      authBloc.close();
    });

    testWidgets('can enter text in email and password fields', (
      WidgetTester tester,
    ) async {
      final authBloc = AuthBloc();

      await tester.pumpWidget(createTestWidget(authBloc));
      await tester.pump();

      final emailField = find.byType(TextField).first;
      final passwordField = find.byType(TextField).last;

      await tester.enterText(emailField, 'test@example.com');
      await tester.enterText(passwordField, 'password123');
      await tester.pump();

      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('password123'), findsOneWidget);

      authBloc.close();
    });

    testWidgets('triggers AuthLoginRequested when sign in button is tapped', (
      WidgetTester tester,
    ) async {
      final authBloc = AuthBloc();

      await tester.pumpWidget(createTestWidget(authBloc));
      await tester.pumpAndSettle();

      // Verify initial state
      expect(authBloc.state, isA<AuthInitial>());

      // Enter credentials
      await tester.enterText(find.byType(TextField).first, 'test@example.com');
      await tester.enterText(find.byType(TextField).last, 'password123');
      await tester.pump();

      // Find the GradientButton widget
      final gradientButton = find.byType(ElevatedButton).first;

      // Ensure button is visible
      await tester.ensureVisible(gradientButton);
      await tester.pump();

      // Verify button exists
      expect(gradientButton, findsOneWidget);

      // Tap sign in button
      await tester.tap(gradientButton);
      await tester.pump();

      // Wait for the event to be processed and state to change
      // Multiple pumps to ensure state propagation
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));

      // Verify that state changed to AuthLoading (which means event was processed)
      expect(authBloc.state, isA<AuthLoading>());

      // Flush all pending timers to avoid test failure
      await tester.pump(const Duration(seconds: 2));

      authBloc.close();
    });
  });
}
