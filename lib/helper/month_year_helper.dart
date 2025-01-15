import 'package:intl/intl.dart';

class MonthYearHelper {
  /// Sorts a list of month-year strings in descending order (most recent first).
  ///
  /// The input list should contain strings in the format "Month - Year",
  /// e.g., "December - 2024".
  ///
  /// Returns a new list with the strings sorted, or the original list if it's empty.
  /// Returns null if the list contains invalid formats.
  static List<String>? sortMonthYearList(List<String> availableMonths) {
    if (availableMonths.isEmpty) {
      return availableMonths;
    }

    // Parse each string into a DateTime object for comparison.
    List<DateTime> dateTimes = [];
    for (String monthYearString in availableMonths) {
      DateTime? dateTime = _parseMonthYearString(monthYearString);
      if (dateTime != null) {
        dateTimes.add(dateTime);
      } else {
        // Handle invalid format (e.g., log an error, skip, or return null).
        print('Invalid month-year format: $monthYearString');
        return null;
      }
    }

    // Sort the DateTime objects in descending order.
    dateTimes.sort((a, b) => b.compareTo(a));

    // Format the sorted DateTime objects back into strings.
    List<String> sortedMonths = [];
    for (DateTime dateTime in dateTimes) {
      sortedMonths.add(DateFormat('MMMM - yyyy').format(dateTime));
    }

    return sortedMonths;
  }

  /// Parses a month-year string (e.g., "December - 2024") into a DateTime object.
  ///
  /// Returns a DateTime object or null if the string is not in the correct format.
  static DateTime? _parseMonthYearString(String monthYearString) {
    try {
      List<String> parts = monthYearString.split(' - ');
      if (parts.length != 2) {
        return null;
      }
      String monthName = parts[0];
      int year = int.parse(parts[1]);

      // Use DateFormat to parse the month name.
      DateTime dateTime = DateFormat('MMMM').parse(monthName);

      // Create a new DateTime with the correct year.
      return DateTime(year, dateTime.month);
    } catch (e) {
      return null;
    }
  }
}