import '../services/auth.dart';
import '../utils/k_verify_email.dart';
import 'routes.dart';

String? guardRedirect([Uri? uri]) {
  final firstSegment = uri?.pathSegments.firstOrNull;
  final user = Auth.instance.currentUser;
  if (user != null) {
    if (firstSegment == 'login') {
      return const HomeRoute().location;
    }
    if (!user.emailVerified && kVerifyEmail) {
      if (firstSegment != 'verify-email') {
        throw UnimplementedError();
      }
    } else {
      if (firstSegment == 'verify-email') {
        return const HomeRoute().location;
      }
    }
    throw UnimplementedError(); // Return games route.
  } else {
    if (firstSegment != 'login') {
      return const LoginRoute().location;
    } else {
      return null;
    }
  }
}
