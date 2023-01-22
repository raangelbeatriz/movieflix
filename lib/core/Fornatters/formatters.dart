import 'package:intl/intl.dart';

class Formatters {
  static String dateFormater(DateTime? date) {
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = "";
    if (date != null) {
      formattedDate = formatter.format(date);
    }
    return formattedDate;
  }
}
