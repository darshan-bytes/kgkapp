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
    DateFormat dateFormat = DateFormat(outputDateFormat);
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
