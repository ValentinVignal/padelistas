import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:padelistas/screens/home/home.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeRoute>(path: '/')
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Home();
  }
}
