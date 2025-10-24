import 'package:intl/intl.dart';

class DateFormatter {
  static String format(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }
}
