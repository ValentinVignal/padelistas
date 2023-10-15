import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'user.dart';

final usersProvider = StreamProvider.autoDispose<List<User>>((ref) {
  return FirebaseFirestore.instance
      .collection('users')
      .orderBy('isApproved')
      .orderBy('firstName')
      .orderBy('lastName')
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map(
              (doc) => User.fromJsonDocument(doc.id, doc.data()),
            )
            .toList(),
      );
});
