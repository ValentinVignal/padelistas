import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/login/login.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/sign_up/sign_up.dart';
import '../screens/verify_email/verify_email_screen.dart';
import '../screens/waiting_for_approval/waiting_for_approval_screen.dart';
import 'redirect.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeRoute>(path: '/')
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    return guardRedirect(state.uri);
  }
}

@TypedGoRoute<LoginRoute>(
  path: '/login',
  routes: [
    TypedGoRoute<SignUpRoute>(path: 'sign-up'),
  ],
)
class LoginRoute extends GoRouteData {
  const LoginRoute({
    this.redirectUrl,
  });

  final Uri? redirectUrl;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

class SignUpRoute extends GoRouteData {
  const SignUpRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignUpScreen();
  }
}

@TypedGoRoute<VerifyEmailRoute>(path: '/verify-email')
class VerifyEmailRoute extends GoRouteData {
  const VerifyEmailRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const VerifyEmailScreen();
  }
}

@TypedGoRoute<WaitingForApprovalRoute>(path: '/waiting-for-approval')
class WaitingForApprovalRoute extends GoRouteData {
  const WaitingForApprovalRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const WaitingForApprovalScreen();
  }
}

@TypedGoRoute<SettingsRoute>(path: '/settings')
class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsScreen();
  }
}
