import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moe_cfims/domain/auth/auth_value_objects.dart';

part 'account.freezed.dart';

@freezed
class Account with _$Account {
  const Account._();

  const factory Account({
    required String id,
    required String username,
    required EmailAddress email,
    required String image,
  }) = _Account;

  factory Account.empty() => Account(
        id: "0",
        username: "",
        email: EmailAddress(""),
        image: "",
      );
}
