import 'dart:async';

import '../services/auth.dart';
import '../services/user_notifier.dart';
import '../utils/value_notifier.dart';
import '../utils/verify_email.dart';
import 'routes.dart';

Future<String?> guardRedirect([Uri? uri]) async {
  final firstSegment = uri?.pathSegments.firstOrNull;
  final authUser = Auth.instance.currentUser;
  if (authUser != null) {
    // The user is logged in.
    if (firstSegment == LoginRoute.path) {
      return const HomeRoute().location;
    }
    if (!authUser.emailVerified && verifyEmail) {
      if (!const {VerifyEmailRoute.path, PublicSettingsRoute.path}
          .contains(firstSegment)) {
        return const VerifyEmailRoute().location;
      }
    } else {
      if (firstSegment == VerifyEmailRoute.path) {
        return const HomeRoute().location;
      }
      if (!userNotifier.hasLoaded) {
        await userNotifier.waitForValue();
      }
      if (!userNotifier.isProfileSetup) {
        if (!const {SetUpProfileRoute.path, PublicSettingsRoute.path}
            .contains(firstSegment)) {
          return const SetUpProfileRoute().location;
        }
      } else {
        if (!userNotifier.user!.isApprovedNullSafe) {
          if (!const {WaitingForApprovalRoute.path, PublicSettingsRoute.path}
              .contains(firstSegment)) {
            return const WaitingForApprovalRoute().location;
          }
        } else {
          if (firstSegment == WaitingForApprovalRoute.path) {
            return const HomeRoute().location;
          } else if (firstSegment == PublicSettingsRoute.path) {
            return const SettingsRoute().location;
          }
        }
      }
    }
    if (firstSegment == null) {
      return const GamesRoute().location;
    }
  } else {
    // The user is not logged in.
    if (!_unauthenticatedRoutes.contains(firstSegment)) {
      return const LoginRoute().location;
    } else {
      return null;
    }
  }
  return null;
}

/// Routes that you can access when you are not authenticated
const _unauthenticatedRoutes = {
  LoginRoute.path,
  PublicSettingsRoute.path,
};
