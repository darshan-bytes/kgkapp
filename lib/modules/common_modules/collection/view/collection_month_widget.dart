import 'package:kgk/kgk.dart';

class MonthTabWidget extends StatelessWidget {
  final DateTime monthDate;

  const MonthTabWidget({required this.monthDate, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: 6.w, end: 6.w, top: 14.h, bottom: 7.h),
      child: Tab(
        child: Column(
          children: [
            SmartText(monthDate.toLocal().dateToStringFormat(outputDateFormat: DateFormatter.dateFormatMMMM)),
            SizedBox(height: 4.h),
            SmartText(monthDate.year.toString()),
          ],
        ),
      ),
    );
  }
}
