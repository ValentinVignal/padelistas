import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/games/filters/games_filter_provider.dart';
import '../utils/date.dart';
import 'game.dart';

final gamesProvider = StreamProvider.autoDispose<List<Game>>(
  (ref) async* {
    final parameters = ref.watch(gamesRouteParametersProvider);
    var query = FirebaseFirestore.instance.collection('games').orderBy('date');
    if (!parameters.all) {
      query = query.where('date', isGreaterThan: DateTime.now().rounded());
    }
    if (parameters.creator.isNotEmpty) {
      query = query.where('createdBy', whereIn: parameters.creator);
    }
    if (parameters.player.isNotEmpty) {
      query = query.where('players', arrayContainsAny: parameters.player);
    }
    yield* query.snapshots().map(
          (snapshot) => snapshot.docs.map(
            (doc) {
              return Game.fromJsonDocument(doc.id, doc.data());
            },
          ).toList(),
        );
  },
  dependencies: [
    gamesRouteParametersProvider,
  ],
);
