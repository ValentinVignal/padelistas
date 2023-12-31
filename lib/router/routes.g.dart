// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeRoute,
      $loginRoute,
      $verifyEmailRoute,
      $waitingForApprovalRoute,
      $setUpProfileRoute,
      $settingsRoute,
      $publicSettingsRoute,
      $gamesRoute,
      $usersRoute,
    ];

RouteBase get $homeRoute => GoRouteData.$route(
      path: '/',
      factory: $HomeRouteExtension._fromState,
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute => GoRouteData.$route(
      path: '/login',
      factory: $LoginRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'sign-up',
          factory: $SignUpRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'reset-password',
          factory: $ResetPasswordRouteExtension._fromState,
        ),
      ],
    );

extension $LoginRouteExtension on LoginRoute {
  static LoginRoute _fromState(GoRouterState state) => LoginRoute(
        redirectUrl: _$convertMapValue(
            'redirect-url', state.uri.queryParameters, Uri.parse),
      );

  String get location => GoRouteData.$location(
        '/login',
        queryParams: {
          if (redirectUrl != null) 'redirect-url': redirectUrl!.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SignUpRouteExtension on SignUpRoute {
  static SignUpRoute _fromState(GoRouterState state) => const SignUpRoute();

  String get location => GoRouteData.$location(
        '/login/sign-up',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ResetPasswordRouteExtension on ResetPasswordRoute {
  static ResetPasswordRoute _fromState(GoRouterState state) =>
      const ResetPasswordRoute();

  String get location => GoRouteData.$location(
        '/login/reset-password',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}

RouteBase get $verifyEmailRoute => GoRouteData.$route(
      path: '/verify-email',
      factory: $VerifyEmailRouteExtension._fromState,
    );

extension $VerifyEmailRouteExtension on VerifyEmailRoute {
  static VerifyEmailRoute _fromState(GoRouterState state) =>
      const VerifyEmailRoute();

  String get location => GoRouteData.$location(
        '/verify-email',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $waitingForApprovalRoute => GoRouteData.$route(
      path: '/waiting-for-approval',
      factory: $WaitingForApprovalRouteExtension._fromState,
    );

extension $WaitingForApprovalRouteExtension on WaitingForApprovalRoute {
  static WaitingForApprovalRoute _fromState(GoRouterState state) =>
      const WaitingForApprovalRoute();

  String get location => GoRouteData.$location(
        '/waiting-for-approval',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $setUpProfileRoute => GoRouteData.$route(
      path: '/set-up-profile',
      factory: $SetUpProfileRouteExtension._fromState,
    );

extension $SetUpProfileRouteExtension on SetUpProfileRoute {
  static SetUpProfileRoute _fromState(GoRouterState state) =>
      const SetUpProfileRoute();

  String get location => GoRouteData.$location(
        '/set-up-profile',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $settingsRoute => GoRouteData.$route(
      path: '/settings',
      factory: $SettingsRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'my-account',
          factory: $MyAccountRouteExtension._fromState,
        ),
      ],
    );

extension $SettingsRouteExtension on SettingsRoute {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  String get location => GoRouteData.$location(
        '/settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MyAccountRouteExtension on MyAccountRoute {
  static MyAccountRoute _fromState(GoRouterState state) =>
      const MyAccountRoute();

  String get location => GoRouteData.$location(
        '/settings/my-account',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $publicSettingsRoute => GoRouteData.$route(
      path: '/public-settings',
      factory: $PublicSettingsRouteExtension._fromState,
    );

extension $PublicSettingsRouteExtension on PublicSettingsRoute {
  static PublicSettingsRoute _fromState(GoRouterState state) =>
      const PublicSettingsRoute();

  String get location => GoRouteData.$location(
        '/public-settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $gamesRoute => GoRouteData.$route(
      path: '/games',
      factory: $GamesRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'new',
          factory: $NewGameRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: ':id',
          factory: $GameRouteExtension._fromState,
        ),
      ],
    );

extension $GamesRouteExtension on GamesRoute {
  static GamesRoute _fromState(GoRouterState state) => GamesRoute(
        creator:
            state.uri.queryParametersAll['creator']?.map((e) => e).toSet() ??
                const {},
        player: state.uri.queryParametersAll['player']?.map((e) => e).toSet() ??
            const {},
        all: _$convertMapValue(
                'all', state.uri.queryParameters, _$boolConverter) ??
            false,
      );

  String get location => GoRouteData.$location(
        '/games',
        queryParams: {
          if (creator != const {}) 'creator': creator.map((e) => e).toList(),
          if (player != const {}) 'player': player.map((e) => e).toList(),
          if (all != false) 'all': all.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $NewGameRouteExtension on NewGameRoute {
  static NewGameRoute _fromState(GoRouterState state) => const NewGameRoute();

  String get location => GoRouteData.$location(
        '/games/new',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $GameRouteExtension on GameRoute {
  static GameRoute _fromState(GoRouterState state) => GameRoute(
        id: state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/games/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

bool _$boolConverter(String value) {
  switch (value) {
    case 'true':
      return true;
    case 'false':
      return false;
    default:
      throw UnsupportedError('Cannot convert "$value" into a bool.');
  }
}

RouteBase get $usersRoute => GoRouteData.$route(
      path: '/users',
      factory: $UsersRouteExtension._fromState,
    );

extension $UsersRouteExtension on UsersRoute {
  static UsersRoute _fromState(GoRouterState state) => const UsersRoute();

  String get location => GoRouteData.$location(
        '/users',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
