import 'package:intl/intl.dart';

String getFormattedDate() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat("dd/MM/yy h:mm a");
  return formatter.format(now);
}