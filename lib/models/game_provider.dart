import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'game.dart';

final gameProvider = StreamProvider.autoDispose.family<Game, String>((ref, id) {
  return FirebaseFirestore.instance.collection('games').doc(id).snapshots().map(
    (doc) {
      return Game.fromJsonDocument(doc.id, doc.data()!);
    },
  );
});
