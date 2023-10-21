import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authUserNotifier = _getUserNotifier();

ValueNotifier<User?> _getUserNotifier() {
  final userNotifier = ValueNotifier<User?>(null);

  FirebaseAuth.instance.userChanges().listen(
    (user) {
      userNotifier.value = user;
      FirebaseAnalytics.instance.setUserId(id: user?.uid);
    },
  );
  return userNotifier;
}

final loggedInAuthUserProvider =
    ChangeNotifierProvider<ValueNotifier<User?>>((ref) {
  return authUserNotifier;
});

extension UserNotifierExtension on ValueNotifier<User?> {
  bool get isLoggedIn => value != null;
}
