import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart' as prod;
import 'firebase_options_dev.dart' as dev;
import 'services/env.dart';

mixin DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (env) {
      case Env.prod:
        return prod.DefaultFirebaseOptions.currentPlatform;
      case Env.dev:
        return dev.DefaultFirebaseOptions.currentPlatform;
    }
  }
}
