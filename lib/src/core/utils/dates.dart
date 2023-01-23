import 'package:intl/intl.dart';

abstract class Dates {
  static DateTime fromDatetime(String date, String locale) {
    return DateFormat.yMMMMd(locale).parse(date);
  }
}