import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/games/game/game_screen.dart';
import '../screens/games/games_screen.dart';
import '../screens/login/login.dart';
import '../screens/my_account/my_account_screen.dart';
import '../screens/reset_password/reset_password_screen.dart';
import '../screens/set_up_profile/set_up_profile_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/sign_up/sign_up.dart';
import '../screens/users/users_screen.dart';
import '../screens/verify_email/verify_email_screen.dart';
import '../screens/waiting_for_approval/waiting_for_approval_screen.dart';
import '../services/user_notifier.dart';
import '../utils/value_notifier.dart' hide ValueNotifierExtension;
import 'pages/bottom_sheet_page.dart';
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
  path: '/${LoginRoute.path}',
  routes: [
    TypedGoRoute<SignUpRoute>(path: 'sign-up'),
    TypedGoRoute<ResetPasswordRoute>(path: 'reset-password'),
  ],
)
class LoginRoute extends GoRouteData {
  const LoginRoute({
    this.redirectUrl,
  });

  final Uri? redirectUrl;

  static const path = 'login';

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

class ResetPasswordRoute extends GoRouteData {
  const ResetPasswordRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ResetPasswordScreen();
  }
}

@TypedGoRoute<VerifyEmailRoute>(path: '/${VerifyEmailRoute.path}')
class VerifyEmailRoute extends GoRouteData {
  const VerifyEmailRoute();

  static const path = 'verify-email';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const VerifyEmailScreen();
  }
}

@TypedGoRoute<WaitingForApprovalRoute>(path: '/${WaitingForApprovalRoute.path}')
class WaitingForApprovalRoute extends GoRouteData {
  const WaitingForApprovalRoute();

  static const path = 'waiting-for-approval';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const WaitingForApprovalScreen();
  }
}

@TypedGoRoute<SetUpProfileRoute>(path: '/${SetUpProfileRoute.path}')
class SetUpProfileRoute extends GoRouteData {
  const SetUpProfileRoute();

  static const path = 'set-up-profile';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SetUProfileScreen();
  }
}

@TypedGoRoute<SettingsRoute>(
  path: '/${SettingsRoute.path}',
  routes: [
    TypedGoRoute<MyAccountRoute>(
      path: MyAccountRoute.path,
    )
  ],
)
class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  static const path = 'settings';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsScreen(
      public: false,
    );
  }
}

@TypedGoRoute<PublicSettingsRoute>(
  path: '/${PublicSettingsRoute.path}',
)
class PublicSettingsRoute extends GoRouteData {
  const PublicSettingsRoute();

  static const path = 'public-settings';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsScreen(public: true);
  }
}

class MyAccountRoute extends GoRouteData {
  const MyAccountRoute();

  static const path = 'my-account';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MyAccountScreen();
  }
}

@TypedGoRoute<GamesRoute>(
  path: '/${GamesRoute.path}',
  routes: [
    TypedGoRoute<NewGameRoute>(path: 'new'),
    TypedGoRoute<GameRoute>(path: ':id'),
  ],
)
class GamesRoute extends GoRouteData {
  const GamesRoute();

  static const path = 'games';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const GamesScreen();
  }
}

class NewGameRoute extends GoRouteData {
  const NewGameRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return BottomSheetPage(
      key: state.pageKey,
      child: const GameScreen(
        id: null,
      ),
    );
  }
}

class GameRoute extends GoRouteData {
  const GameRoute({
    required this.id,
  });

  final String id;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return BottomSheetPage(
      key: state.pageKey,
      child: GameScreen(id: id),
    );
  }
}

@TypedGoRoute<UsersRoute>(path: '/${UsersRoute.path}')
class UsersRoute extends GoRouteData {
  const UsersRoute();

  static const path = 'users';

  @override
  Future<String?> redirect(BuildContext context, GoRouterState state) async {
    final user = await userNotifier.waitForValue();
    if (!(user?.isAdmin ?? false)) return const HomeRoute().location;
    return null;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UsersScreen();
  }
}
