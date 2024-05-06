import 'package:dartz/dartz.dart';
import 'package:moe_cfims/domain/core/failures.dart';

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  const emailRegex = r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidEmail(failedValue: input));
  }
}

Either<ValueFailure<List<T>>, List<T>> validateMaxGuildLength<T>(
  List<T> input,
  int maxLength,
) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(
      ValueFailure.tooManyGuilds(
        failedValue: input,
        max: maxLength,
      ),
    );
  }
}

Either<ValueFailure<String>, String> validateMaxStringLength(
  String input,
  int maxLength,
) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(
      ValueFailure.exceedingLength(failedValue: input, max: maxLength),
    );
  }
}

Either<ValueFailure<String>, String> validateHexColor(
  String input,
) {
  const hexRegex = r"""^#[0-9a-f]{3}(?:[0-9a-f]{3})?$""";
  if (RegExp(hexRegex, caseSensitive: false).hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidColor(failedValue: input));
  }
}
