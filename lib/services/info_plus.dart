import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final infoPlusProvider =
    FutureProvider<PackageInfo>((ref) => PackageInfo.fromPlatform());
