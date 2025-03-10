import 'package:intl/intl.dart';

String getFormattedDate() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat("dd/MM/yy h:mm a");
  return formatter.format(now);
  }
String formatTime(String time) {
  final parsedTime = DateFormat("HH:mm:ss").parse(time);
  return DateFormat("h:mm a").format(parsedTime);
}