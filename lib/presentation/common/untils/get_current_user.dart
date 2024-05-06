import 'package:hive/hive.dart';
// import 'package:moe_cfims/application/account.dart';
import 'package:moe_cfims/domain/account/account.dart';
import 'package:moe_cfims/infrastructure/account/account_entity.dart';
import 'package:moe_cfims/infrastructure/core/hive_box_names.dart';

Account getCurrentUser() {
  final accountBox = Hive.box<AccountEntity>(BoxNames.currentUser);
  return accountBox.get(BoxKeys.currentAccount)!.toDomain();
}

bool doesCurrentUserExist() {
  final accountBox = Hive.box<AccountEntity>(BoxNames.currentUser);
  return accountBox.get(BoxKeys.currentAccount) != null;
}
