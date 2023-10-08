import '../services/auth.dart';
import '../services/user_notifier.dart';
import '../utils/k_verify_email.dart';
import 'routes.dart';

String? guardRedirect([Uri? uri]) {
  final firstSegment = uri?.pathSegments.firstOrNull;
  if (firstSegment != null && _whiteListRoutes.contains(firstSegment)) {
    return null;
  }
  final user = Auth.instance.currentUser;
  if (user != null) {
    if (firstSegment == 'login') {
      return const HomeRoute().location;
    }
    if (!user.emailVerified && kVerifyEmail) {
      if (firstSegment != 'verify-email') {
        return const VerifyEmailRoute().location;
      }
    } else {
      if (firstSegment == 'verify-email') {
        return const HomeRoute().location;
      }
      if (!userNotifier.isProfileSetup) {
        if (firstSegment != 'set-up-profile') {
          return const SetUpProfileRoute().location;
        }
      } else {
        if (firstSegment == 'set-up-profile') {
          return const HomeRoute().location;
        }
        if (!userNotifier.value!.isApproved) {
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
