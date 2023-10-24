import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import 'auth_user_notifier.dart';

final userNotifier = _getUserNotifier();

final _isUserLoaded = StreamController<bool>.broadcast();
Stream<bool> get isUserLoaded => _isUserLoaded.stream;

ValueNotifier<User?> _getUserNotifier() {
  final userNotifier = ValueNotifier<User?>(null);

  StreamSubscription<User?>? userStreamSubscription;

  authUserNotifier.addListener(
    () async {
      if (!authUserNotifier.isLoggedIn) {
        userNotifier.value = null;
        return;
      }
      final userStream = FirebaseFirestore.instance
          .collection('users')
          .doc(authUserNotifier.value!.uid)
          .snapshots()
          .map(
        (snapshot) {
          final data = snapshot.data();
          if (data == null) {
            _isUserLoaded.add(false);
            return null;
          }
          _isUserLoaded.add(true);
          return User.fromJsonDocument(snapshot.id, data);
        },
      );
      userStreamSubscription?.cancel();
      userStreamSubscription = userStream.listen(
        (user) {
          userNotifier.value = user;
        },
        onError: (Object error, StackTrace stackTrace) {
          if (error
              .toString()
              .contains('FirebaseError: [code=permission-denied]')) {
            // Ignore permission denied errors as it will happen when login
            // out.
            return;
          }
          Zone.current.handleUncaughtError(error, stackTrace);
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
  bool get isAdmin => value?.isAdmin ?? false;
}
