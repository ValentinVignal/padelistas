import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'game.dart';

final gamesProvider = StreamProvider.autoDispose<List<Game>>((ref) {
  return FirebaseFirestore.instance
      .collection('games')
      .orderBy('date')
      .where('date', isGreaterThan: DateTime.now())
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map(
              (doc) => Game.fromJsonDocument(doc.id, doc.data()),
            )
            .toList(),
      );
});
