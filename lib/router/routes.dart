import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:padelistas/router/pages/bottom_sheet_page.dart';
import 'package:padelistas/screens/events/event/event_create_screen.dart';
import 'package:padelistas/screens/events/events_screen.dart';
import 'package:padelistas/screens/login/login.dart';
import 'package:padelistas/screens/sign_up/sign_up.dart';

import '../screens/home/home.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/users/users_screen.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [
    TypedGoRoute<LoginRoute>(path: 'login'),
    TypedGoRoute<SignUpRoute>(path: 'sign-up'),
    TypedGoRoute<UsersRoute>(path: 'users'),
    TypedGoRoute<EventsRoute>(
      path: 'events',
      routes: [
        TypedGoRoute<EventCreateRoute>(path: 'create'),
      ],
    ),
    TypedGoRoute<SettingsRoute>(path: 'settings'),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Home();
  }
}

class UsersRoute extends GoRouteData {
  const UsersRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UsersScreen();
  }
}

class EventsRoute extends GoRouteData {
  const EventsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const EventsScreen();
  }
}

class EventCreateRoute extends GoRouteData {
  const EventCreateRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return BottomSheetPage(
      key: state.pageKey,
      child: const EventCreateScreen(),
    );
  }
}

class LoginRoute extends GoRouteData {
  const LoginRoute();

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

class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsScreen();
  }
}
