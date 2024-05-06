import 'package:dartz/dartz.dart';
import 'package:moe_cfims/domain/auth/auth_failure.dart';
import 'package:moe_cfims/domain/auth/auth_value_objects.dart';

abstract class IAuthFacade {
  Future<Either<AuthFailure, Unit>> login({required EmailAddress emailAddress});

  Future<bool> checkAuthenticated();

  Future<void> logout();
}
