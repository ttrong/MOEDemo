import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moe_cfims/domain/account/account.dart';
import 'package:moe_cfims/domain/auth/auth_value_objects.dart';

part 'account_dto.freezed.dart';
part 'account_dto.g.dart';

@freezed
class AccountDto with _$AccountDto {
  const AccountDto._();

  const factory AccountDto({
    required String id,
    required String username,
    required String email,
    required String image,
  }) = _AccountDto;

  Account toDomain() {
    return Account(
      id: id,
      username: username,
      email: EmailAddress(email),
      image: image,
    );
  }

  factory AccountDto.fromDomain(Account account) {
    return AccountDto(
      id: account.id,
      username: account.username,
      email: account.email.getOrCrash(),
      image: account.image,
    );
  }

  factory AccountDto.fromJson(Map<String, dynamic> json) => _$AccountDtoFromJson(json);
}
