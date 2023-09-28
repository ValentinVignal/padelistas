import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'user.dart';

const _users = [
  User(id: '1', name: 'John'),
  User(id: '2', name: 'Maggie'),
  User(id: '3', name: 'Fred'),
  User(id: '4', name: 'Roger'),
];

final usersProvider = StreamProvider.autoDispose<List<User>>((ref) async* {
  yield _users;
});
