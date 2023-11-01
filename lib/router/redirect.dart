import 'dart:async';

import '../services/auth.dart';
import '../services/user_notifier.dart';
import '../utils/k_verify_email.dart';
import '../utils/value_notifier.dart';
import 'routes.dart';

Future<String?> guardRedirect([Uri? uri]) async {
  final firstSegment = uri?.pathSegments.firstOrNull;
  if (firstSegment != null && _whiteListRoutes.contains(firstSegment)) {
    return null;
  }
  final authUser = Auth.instance.currentUser;
  if (authUser != null) {
    if (firstSegment == 'login') {
      return const HomeRoute().location;
    }
    if (!authUser.emailVerified && kVerifyEmail) {
      if (firstSegment != 'verify-email') {
        return const VerifyEmailRoute().location;
      }
    } else {
      if (firstSegment == 'verify-email') {
        return const HomeRoute().location;
      }
      if (!userNotifier.hasLoaded) {
        await userNotifier.waitForValue();
      }
      if (!userNotifier.isProfileSetup) {
        if (firstSegment != 'set-up-profile') {
          return const SetUpProfileRoute().location;
        }
      } else {
        if (firstSegment == 'set-up-profile') {
          return const HomeRoute().location;
        }
        if (!userNotifier.user!.isApprovedNullSafe) {
          if (firstSegment != 'waiting-for-approval') {
            return const WaitingForApprovalRoute().location;
          }
        } else {
          if (firstSegment == 'waiting-for-approval') {
            return const HomeRoute().location;
          }
        }
      }
    }
    if (firstSegment == null) {
      return const GamesRoute().location;
    }
  } else {
    if (firstSegment != 'login') {
      return const LoginRoute().location;
    } else {
      return null;
    }
  }
  return null;
}

/// Routes that are accessible when logged in or not.
final _whiteListRoutes = {
  'settings',
};
