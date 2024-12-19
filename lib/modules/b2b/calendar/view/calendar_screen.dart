import 'package:kgk/kgk.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CalendarBloc bloc = BlocProvider.of<CalendarBloc>(context);

    final CalendarStyle style = AppTheme.of(context).calendarStyle;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SmartAppBar(title: APPStrings.calendar.tr),
      body: SafeArea(
        child: SmartSingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Column(
            children: [
              _buildHeaderRow(bloc, style, context),
              SizedBox(height: 24.h),
              _buildSearchFieldAndMenuButton(context, bloc, style),
              SizedBox(height: 24.h),
              Container(
                height: 40.h,
                margin: EdgeInsets.symmetric(horizontal: 17.w),
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  border: Border.all(color: style.borderColor, width: 1.w),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: BlocBuilder<CalendarBloc, CalendarState>(
                  buildWhen: (previous, current) => previous != current && current is CalendarViewChangeState,
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: SmartButton(
                            height: 32.h,
                            padding: EdgeInsets.zero,
                            title: APPStrings.day.tr,
                            onTap: () {
                              bloc.add(CalendarViewChangeEvent(CalendarView.day, context));
                            },
                            isWhite: bloc.calendarView != CalendarView.day,
                            titleStyle: style.calendarViewChangeButtonStyle,
                          ),
                        ),
                        Expanded(
                          child: SmartButton(
                            height: 32.h,
                            padding: EdgeInsets.zero,
                            title: APPStrings.week.tr,
                            onTap: () {
                              bloc.add(CalendarViewChangeEvent(CalendarView.week, context));
                            },
                            isWhite: bloc.calendarView != CalendarView.week,
                            titleStyle: style.calendarViewChangeButtonStyle,
                          ),
                        ),
                        Expanded(
                          child: SmartButton(
                            height: 32.h,
                            padding: EdgeInsets.zero,
                            title: APPStrings.month.tr,
                            onTap: () {
                              bloc.add(CalendarViewChangeEvent(CalendarView.month, context));
                            },
                            isWhite: bloc.calendarView != CalendarView.month,
                            titleStyle: style.calendarViewChangeButtonStyle,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h),
              _buildCalenderView(bloc, style, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderRow(CalendarBloc bloc, CalendarStyle style, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<CalendarBloc, CalendarState>(
            buildWhen: (previous, current) =>
                previous != current && current is CalendarLoadedState || current is CalendarOnViewChangedState,
            builder: (context, state) {
              return InkWell(
                onTap: () {
                  Utils.showSmartModalBottomSheet(
                      context: context,
                      isScrollControlled: false,
                      builder: (context) {
                        return CustomMonthYearPicker(
                            initialDate: bloc.selectedMonth,
                            onDateChanged: (date) {
                              bloc.add(InitialCalendarEvent(context, selectedDate: date));
                            });
                      });
                },
                borderRadius: BorderRadius.circular(4.r),
                child: Row(
                  children: [
                    SmartText(
                      bloc.selectedMonth.monthNameShort,
                      style: style.currentMonthHeaderStyle,
                    ),
                    SizedBox(width: 4.w),
                    SmartImage(
                      path: AppImages.icArrowDown,
                      color: style.dropDownArrowColor,
                    ),
                  ],
                ),
              );
            },
          ),
          InkWell(
            onTap: () {
              _showEventTypeSelectPopup(context, bloc);
            },
            borderRadius: BorderRadius.circular(4.r),
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(
                children: [
                  SmartText(APPStrings.viewColon.tr, style: style.viewAllStyle),
                  SizedBox(width: 6.w),
                  BlocBuilder<CalendarBloc, CalendarState>(
                    buildWhen: (previous, current) => current is CalendarEventTypeChangeState || current is CalendarLoadedState,
                    builder: (context, state) {
                      return SmartText(bloc.selectedCalendarEventType?.title, style: style.viewAllStyle);
                    },
                  ),
                  SizedBox(width: 4.w),
                  const SmartImage(path: AppImages.icArrowDropDown),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchFieldAndMenuButton(BuildContext context, CalendarBloc bloc, CalendarStyle style) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      child: Row(
        children: [
          Expanded(
            child: SmartTextField.search(
              height: 48.w,
              prefixIconSize: 10.w,
              hintText: APPStrings.searchAuction.tr,
              controller: bloc.searchController,
              textInputAction: TextInputAction.search,
              onTapOutside: (p) {},
              onValueChanges: (p) {
                bloc.add(CalenderSearchEvent(context));
              },
            ),
          ),

          /// NOTE :: MENU BUTTON IS HIDDEN AS OF NOW TO KEEP SIMILARITY WITH WEB
          // SizedBox(width: 16.w),
          // SelectionButton(
          //   width: 48.w,
          //   imageHeight: 24.5.w,
          //   imageWidth: 24.5.w,
          //   isSelected: false,
          //   image: AppImages.icMenu,
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }

  Widget _buildCalenderView(CalendarBloc bloc, CalendarStyle style, BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      buildWhen: (previous, current) => previous != current && current is CalendarLoadedState,
      builder: (context, state) {
        return Container(
          constraints: BoxConstraints(maxHeight: 600.h),
          child: SfCalendar(
            onViewChanged: (viewChangeDetails) => bloc.add(CalendarOnViewChangedEvent(viewChangeDetails, context)),
            dataSource: bloc.meetingDataSource,
            view: bloc.calendarView,
            controller: bloc.calendarController,
            cellBorderColor: style.borderColor,
            selectionDecoration: BoxDecoration(border: Border.all(color: style.primary, width: 1.w)),
            monthViewSettings: const MonthViewSettings(
              appointmentDisplayCount: 3,
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            ),
            timeSlotViewSettings: const TimeSlotViewSettings(
              startHour: 0,
              endHour: 24,
              minimumAppointmentDuration: Duration(seconds: 30),
            ),
            todayHighlightColor: style.primary,
            firstDayOfWeek: 7,
            headerStyle: const CalendarHeaderStyle(),
            headerHeight: 0,
            appointmentTextStyle: style.meetEventTextStyle,
            allowAppointmentResize: true,
            onTap: (CalendarTapDetails details) {
              bloc.add(CalendarOnCellTapEvent(details, context));
            },
          ),
        );
      },
    );
  }

  void _showEventTypeSelectPopup(BuildContext context, CalendarBloc bloc) {
    OrderPopupStyle orderPopupStyle = AppTheme.of(context).orderPopupStyle;
    Utils.showSmartModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
        ),
        builder: (subContext) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
              color: orderPopupStyle.whiteColor,
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  bloc.calendarEventTypeList.length,
                  (index) {
                    CalendarEventTypeModel eventType = bloc.calendarEventTypeList[index];
                    return _buildPopupOption(
                      subContext,
                      text: eventType.title ?? '-',
                      style: orderPopupStyle.optionTextStyle,
                      onTap: () async {
                        bloc.add(CalendarEventTypeChangeEvent(eventType, context));
                        subContext.pop();
                      },
                    );
                  },
                ),
              ),
            ),
          );
        });
  }

  Widget _buildPopupOption(
    BuildContext context, {
    required String text,
    required TextStyle style,
    EdgeInsets? padding,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56.h,
        width: context.width,
        alignment: Alignment.centerLeft,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w),
        child: SmartText(text, style: style),
      ),
    );
  }
}
