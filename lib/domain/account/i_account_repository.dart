import 'package:dartz/dartz.dart';
import 'package:moe_cfims/domain/account/account.dart';
import 'package:moe_cfims/domain/account/account_failure.dart';

abstract class IAccountRepository {
  Future<Either<AccountFailure, Account>> getAccount();
}
