import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    // It is what freezed recommends.
    //
    // ignore: invalid_annotation_target
    @JsonKey(includeToJson: false) required String id,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    bool? isApproved,
    @Default(false) bool isAdmin,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  factory User.fromJsonDocument(String id, Json document) => User.fromJson({
        ...document,
        'id': id,
      });

  const User._();

  bool get isApprovedNullSafe => isApproved ?? false;

  String get fullName => '$firstName $lastName';
}
