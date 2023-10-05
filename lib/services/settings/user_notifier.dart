import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userNotifier = _getUserNotifier();

ValueNotifier<User?> _getUserNotifier() {
  final userNotifier = ValueNotifier<User?>(null);

  FirebaseAuth.instance.userChanges().listen(
    (user) {
      userNotifier.value = user;
    },
  );
  return userNotifier;
}

final loggedInUserProvider =
    ChangeNotifierProvider<ValueNotifier<User?>>((ref) {
  return userNotifier;
});

extension UserNotifierExtension on ValueNotifier<User?> {
  bool get isLoggedIn => value != null;
}
