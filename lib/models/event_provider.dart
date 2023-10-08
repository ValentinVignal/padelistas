import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'event.dart';

final eventsProvider = StreamProvider.autoDispose<List<Event>>((ref) {
  return FirebaseFirestore.instance.collection('events').snapshots().map(
        (snapshot) => snapshot.docs
            .map(
              (doc) => Event.fromJson(doc.data()),
            )
            .toList(),
      );
});
