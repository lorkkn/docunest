import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mydocs/main.dart';
import 'package:mydocs/features/profile/presentation/screens/profile_screen.dart';

void main() {
  testWidgets('App renders LoginScreen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Sign in to your account'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
  });

  testWidgets('Login button navigates to HomeScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    // Tap the Sign In button
    final signInButton = find.widgetWithText(ElevatedButton, 'Sign in');
    expect(signInButton, findsOneWidget);
    await tester.tap(signInButton);
    await tester.pumpAndSettle();

    // Verify HomeScreen is displayed with metrics
    expect(find.text('Welcome back, Alex'), findsOneWidget);
    expect(find.text('Total Documents'), findsOneWidget);
    expect(find.text('National Passport'), findsOneWidget);
  });

  testWidgets('ProfileScreen renders personal details and security section', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfileScreen(),
      ),
    );

    expect(find.text('Profile & Settings'), findsOneWidget);
    expect(find.text('Alex Smith'), findsWidgets);
    expect(find.text('Security'), findsOneWidget);
    expect(find.text('Change Password'), findsOneWidget);
  });
}
