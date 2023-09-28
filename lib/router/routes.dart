import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:padelistas/screens/events/events_screen.dart';

import '../screens/home/home.dart';
import '../screens/users/users_screen.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [
    TypedGoRoute<UsersRoute>(path: 'users'),
    TypedGoRoute<EventsRoute>(path: 'events')
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
