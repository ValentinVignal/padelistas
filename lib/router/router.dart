import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/settings/user_notifier.dart';
import 'redirect.dart';
import 'routes.dart';

final router = GoRouter(
  refreshListenable: userNotifier,
  redirect: (BuildContext context, GoRouterState state) {
    return guardRedirect(state.uri);
  },
  routes: $appRoutes,
);
