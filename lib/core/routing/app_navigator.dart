
import 'package:expense_tracker/core/constants/colors.dart';
import 'package:expense_tracker/src/features/auth/sign_up/presentation/screen/sign_up_screen.dart';
import 'package:expense_tracker/src/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:expense_tracker/src/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../src/features/home/presentation/screens/home_screen.dart';
import 'app_route.dart';

class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoute.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case AppRoute.onboardingScreen:
        return MaterialPageRoute(builder: (context) => const OnboardingScreen());

      case AppRoute.signUpScreen:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());

      case AppRoute.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return const Scaffold(
        backgroundColor: kPrimaryWhite,
        body: Center(
          child: Text('Page Not Found!', style: TextStyle(fontSize: 16)),
        ),
      );
    });
  }

  static Future<Object?> pushNamed(BuildContext context, String routeName,
          {Object? arguments}) =>
      Navigator.pushNamed(context, routeName, arguments: arguments);

  static Future<Object?> pushReplacementNamed(
          BuildContext context, String routeName,
          {Object? arguments, Object? result}) =>
      Navigator.pushReplacementNamed(context, routeName,
          arguments: arguments, result: result);

  static Future<Object?> pushNamedAndRemoveUntil(
    BuildContext context,
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) =>
      Navigator.pushNamedAndRemoveUntil(
        context,
        routeName,
        predicate,
        arguments: arguments,
      );

  static void pop(BuildContext context, [Object? result]) =>
      Navigator.pop(context, result);

  static NavigatorState of(BuildContext context, {bool rootNavigator = false}) =>
      Navigator.of(context, rootNavigator: rootNavigator);

  static Future<Object?> popAndPushNamed(
    BuildContext context,
    String routeName, {
    Object? arguments,
    Object? result,
  }) =>
      Navigator.popAndPushNamed(
        context,
        routeName,
        arguments: arguments,
        result: result,
      );
}
