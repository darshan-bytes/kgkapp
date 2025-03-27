import 'package:kgk/kgk.dart';

extension DateTimeExt on DateTime {
  DateTime get monthStart => DateTime(year, month);

  DateTime get monthEnd => DateTime(year, month + 1, 0);

  DateTime get dayStart => DateTime(year, month, day);

  DateTime get findFirstDateOfTheWeek => subtract(Duration(days: weekday - 1));

  DateTime get findLastDateOfTheWeek => add(Duration(days: DateTime.daysPerWeek - weekday));

  DateTime addMonth(int count) {
    return DateTime(year, month + count, day);
  }

  String dateToStringFormat({required String outputDateFormat}) {
    DateFormat dateFormat = DateFormat(outputDateFormat, StorageManager().getLocale()?.mobileSymbol);
    return dateFormat.format(this);
  }

  bool isSameDate(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }

  bool get isToday {
    return isSameDate(DateTime.now());
  }

  bool get isYesterday {
    return isSameDate(DateTime.now().subtract(const Duration(days: 1)));
  }

  double toNumber() {
    double result = 0;
    result = hour.toDouble();
    result += (minute) / 60;
    result += (second) / 3600;
    return result;
  }

  String get formatDateWithSuffix {
    final day = this.day;
    final month = DateFormat.MMMM().format(this);
    final year = this.year;
    String suffix = 'th';

    if (day % 10 == 1 && day != 11) {
      suffix = 'st';
    } else if (day % 10 == 2 && day != 12) {
      suffix = 'nd';
    } else if (day % 10 == 3 && day != 13) {
      suffix = 'rd';
    }

    return '$day$suffix $month $year';
  }

  String get monthNameShort {
    return DateFormat.MMM().format(this);
  }

  String get monthNameFull {
    return DateFormat.MMMM().format(this);
  }
}

extension DateTimeRangeExt on DateTimeRange {
  formatDateRange() {
    final start = this.start;
    final end = this.end;
    return '${start.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMMYY)} to ${end.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMMYY)}';
  }
}

/// Getter to Get Week Number of the Year
extension ISOWeekOfYear on DateTime {
  String get isoWeekOfYear {
    // Find the first day of the year for the given date
    DateTime firstDayOfYear = DateTime(year, 1, 1);

    // Find the first week of the year (week containing January 4th)
    DateTime firstWeekStart = firstDayOfYear;
    while (firstWeekStart.weekday != DateTime.monday) {
      firstWeekStart = firstWeekStart.subtract(const Duration(days: 1));
    }

    // Calculate the difference in days from the start of the first week
    int daysFromFirstWeekStart = difference(firstWeekStart).inDays;

    // Calculate the ISO week number
    int weekNumber = (daysFromFirstWeekStart / 7).floor() + 1;

    // Handle case where the week number is less than 1 (belongs to the last week of the previous year)
    if (weekNumber < 1) {
      DateTime lastDayOfPreviousYear = DateTime(year - 1, 12, 31);
      return lastDayOfPreviousYear.isoWeekOfYear;
    }

    // Handle case where the week number exceeds 52 (belongs to the first week of the next year)
    if (weekNumber > 52) {
      DateTime firstDayOfNextYear = DateTime(year + 1, 1, 1);
      while (firstDayOfNextYear.weekday != DateTime.monday) {
        firstDayOfNextYear = firstDayOfNextYear.subtract(const Duration(days: 1));
      }
      if (isAfter(firstDayOfNextYear.subtract(const Duration(days: 3)))) {
        return '1/${year + 1}';
      }
    }

    // Return the ISO week number and year
    return '$weekNumber/$year';
  }
}
