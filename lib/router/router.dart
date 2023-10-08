import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/auth_user_notifier.dart';
import '../services/user_notifier.dart';
import 'redirect.dart';
import 'routes.dart';

final _listenable = Listenable.merge([
  authUserNotifier,
  userNotifier,
]);

final router = GoRouter(
  refreshListenable: _listenable,
  redirect: (BuildContext context, GoRouterState state) {
    return guardRedirect(state.uri);
  },
  routes: $appRoutes,
);
