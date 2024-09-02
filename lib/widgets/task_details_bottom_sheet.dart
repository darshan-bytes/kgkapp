import 'package:kgk/kgk.dart';

class TaskDetailsBottomSheet extends StatelessWidget {
  final CalendarData calendarData;

  const TaskDetailsBottomSheet({super.key, required this.calendarData});

  @override
  Widget build(BuildContext context) {
    final TaskDetailsStyle style = AppTheme.of(context).taskDetailsStyle;
    return Container(
      width: context.width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
        color: style.whiteColor,
      ),
      constraints: BoxConstraints(maxHeight: 620.w),
      child: SafeArea(
        child: SmartSingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(context, style),
              _buildDetails(style),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, TaskDetailsStyle style) {
    return Container(
      color: style.headerBgColor,
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SmartText(calendarData.title, style: style.headerTitleStyle),
                  SizedBox(height: 4.h),
                  SmartText(calendarData.categoryName, style: style.headerSubTitleStyle),
                ],
              ),
              const Spacer(),
              SmartImage(
                path: AppImages.icMenu,
                onTap: () {
                  context.pop();
                },
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildStatusAndPriority(style),
        ],
      ),
    );
  }

  Widget _buildStatusAndPriority(TaskDetailsStyle style) {
    return Row(
      children: [
        _buildStatusColumn(style),
        SizedBox(width: 16.w),
        _buildPriorityColumn(style),
      ],
    );
  }

  Widget _buildStatusColumn(TaskDetailsStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SmartText(APPStrings.status.tr, style: style.headerSubTitleStyle),
        Row(
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: style.activeColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8.w),
            SmartText(calendarData.status, style: style.statusStyle),
          ],
        ),
      ],
    );
  }

  Widget _buildPriorityColumn(TaskDetailsStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SmartText(APPStrings.priority.tr, style: style.headerSubTitleStyle),
        Row(
          children: [
            _buildPriorityIndicator(style.activeColor),
            _buildPriorityIndicator(style.disableColor),
            _buildPriorityIndicator(style.disableColor),
            SizedBox(width: 8.w),
            SmartText(calendarData.priority, style: style.statusStyle),
          ],
        ),
      ],
    );
  }

  Widget _buildPriorityIndicator(Color color) {
    return Container(
      width: 5.w,
      height: 17.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(28.r)),
        color: color,
      ),
      margin: EdgeInsets.symmetric(horizontal: 2.51.w),
    );
  }

  Widget _buildDetails(TaskDetailsStyle style) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _detailWidget(
                  title: APPStrings.startDate.tr,
                  subTitle: calendarData.start?.changeDateFormat(inputDateFormat: DateFormatter.dateFormatYYYYMMDDHHMMSS) ?? '',
                  style: style),
              SizedBox(width: 32.w),
              _detailWidget(
                  title: APPStrings.dueDate.tr,
                  subTitle: calendarData.end?.changeDateFormat(inputDateFormat: DateFormatter.dateFormatYYYYMMDDHHMMSS) ?? '',
                  style: style),
            ],
          ),
          _detailWidget(
            title: APPStrings.assignTo.tr.toUpperCamelCase,
            subTitle: calendarData.assignedTo ?? '',
            style: style,
            profileImg: calendarData.assignedToImage,
          ),
          _detailWidget(
            title: APPStrings.description.tr,
            subTitle: calendarData.description ?? '',
            style: style,
          ),
          _detailWidget(
            title: APPStrings.assignFrom.tr,
            subTitle: calendarData.assignedBy ?? '',
            style: style,
            profileImg: calendarData.assignedByImage,
          ),
          _detailWidget(
            title: APPStrings.createdOn.tr,
            subTitle: calendarData.createdDate?.changeDateFormat(
                    inputDateFormat: DateFormatter.dateFormatYYYYMMDDHHMMSS, outputDateFormat: DateFormatter.dateFormatDDMMMYYYYHHMMA) ??
                '',
            style: style,
          )
        ],
      ),
    );
  }

  Widget _detailWidget({
    required String title,
    required String subTitle,
    String? profileImg,
    required TaskDetailsStyle style,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SmartText(title, style: style.headerSubTitleStyle),
        SizedBox(height: 4.h),
        profileImg.isNotNullNorEmpty
            ? Row(
                children: [
                  SmartImage(
                    path: profileImg ?? '',
                    height: 24.w,
                    width: 24.w,
                  ),
                  SizedBox(width: 4.w),
                  SmartText(subTitle, style: style.userNameStyle),
                ],
              )
            : SmartText(subTitle, style: style.userNameStyle),
        SizedBox(height: 24.h),
      ],
    );
  }
}
