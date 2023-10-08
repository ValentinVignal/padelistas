import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import 'auth_user_notifier.dart';

final userNotifier = _getUserNotifier();

ValueNotifier<User?> _getUserNotifier() {
  final userNotifier = ValueNotifier<User?>(null);

  StreamSubscription<User?>? userStreamSubscription;

  authUserNotifier.addListener(
    () async {
      if (!authUserNotifier.isLoggedIn) {
        userNotifier.value = null;
      }
      final userStream = FirebaseFirestore.instance
          .collection('users')
          .doc(authUserNotifier.value!.uid)
          .snapshots()
          .map(
        (snapshot) {
          final data = snapshot.data();
          if (data == null) return null;
          return User.fromJsonDocument(snapshot.id, data);
        },
      );
      userStreamSubscription?.cancel();
      userStreamSubscription = userStream.listen(
        (user) {
          userNotifier.value = user;
        },
      );
    },
  );
  return userNotifier;
}

final loggedInUserProvider =
    ChangeNotifierProvider<ValueNotifier<User?>>((ref) {
  return userNotifier;
});

extension UserNotifierExtension on ValueNotifier<User?> {
  bool get isProfileSetup => value != null;
}
