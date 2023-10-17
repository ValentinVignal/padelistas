import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'user.dart';

final userProvider = StreamProvider.autoDispose.family<User, String>((ref, id) {
  return FirebaseFirestore.instance.collection('users').doc(id).snapshots().map(
        (doc) => User.fromJsonDocument(doc.id, doc.data()!),
      );
});
