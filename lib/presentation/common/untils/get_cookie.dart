import 'package:hive/hive.dart';
import 'package:moe_cfims/infrastructure/core/hive_box_names.dart';

String getCookie() {
  return Hive.box(BoxNames.settingsBox).get(BoxKeys.currentToken).toString();
}
