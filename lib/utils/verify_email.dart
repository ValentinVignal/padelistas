import 'package:flutter/foundation.dart';

import '../services/env.dart';

/// Whether or not the email should be verified before logging in.
final verifyEmail = !(kDebugMode || env == Env.dev);
