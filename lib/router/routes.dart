import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/games/games_screen.dart';
import '../screens/login/login.dart';
import '../screens/set_up_profile/set_up_profile_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/sign_up/sign_up.dart';
import '../screens/users/users_screen.dart';
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

@TypedGoRoute<SetUpProfileRoute>(path: '/set-up-profile')
class SetUpProfileRoute extends GoRouteData {
  const SetUpProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SetUpProfileScreen();
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

@TypedGoRoute<GamesRoute>(path: '/games')
class GamesRoute extends GoRouteData {
  const GamesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const GamesScreen();
  }
}

@TypedGoRoute<UsersRoute>(path: '/users')
class UsersRoute extends GoRouteData {
  const UsersRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UsersScreen();
  }
}
