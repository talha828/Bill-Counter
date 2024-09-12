import 'package:intl/intl.dart';


class Helper{
  static int getDaysInMonth(String monthYear) {
    List<String> parts = monthYear.split(' - ');
    String monthName = parts[0];
    int year = int.parse(parts[1]);

    Map<String, int> monthMap = {
      'January': 1,
      'February': 2,
      'March': 3,
      'April': 4,
      'May': 5,
      'June': 6,
      'July': 7,
      'August': 8,
      'September': 9,
      'October': 10,
      'November': 11,
      'December': 12
    };

    int month = monthMap[monthName]!;

    DateTime firstDayOfNextMonth = DateTime(year, month + 1, 1);
    int daysInMonth = firstDayOfNextMonth.subtract(const Duration(days: 1)).day;

    return daysInMonth;
  }
  // Utility method to get formatted current date
  static String getCurrentDateFormatted() {
    final now = DateTime.now();
    final formatter = DateFormat('MMMM - yyyy');
    return formatter.format(now); // e.g., "August - 2024"
  }
}