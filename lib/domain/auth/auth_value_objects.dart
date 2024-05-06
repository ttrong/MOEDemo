import 'package:dartz/dartz.dart';
import 'package:moe_cfims/domain/core/failures.dart';
import 'package:moe_cfims/domain/core/value_validators.dart';
import 'package:moe_cfims/domain/core/value_objects.dart';

class EmailAddress extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }

  const EmailAddress._(this.value);
}
