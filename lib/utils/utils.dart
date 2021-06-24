import 'package:flutterwebapp/models/users.dart';
import 'package:intl/intl.dart';

typedef UserTapCallback = void Function(User);
typedef OpenPostsCallback = void Function(String userId);

String formatDate(DateTime? date) {
  return date != null ? DateFormat.yMd().format(date) : '';
}

String formatDateTime(DateTime? date) {
  return date != null ? DateFormat.yMd().add_Hms().format(date) : '';
}
