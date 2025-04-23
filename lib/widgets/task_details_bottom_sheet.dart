import 'package:kgk/kgk.dart';

class TaskDetailsBottomSheet extends StatelessWidget {
  final CalenderEventDetailsDataModel calendarData;

  const TaskDetailsBottomSheet({super.key, required this.calendarData});

  @override
  Widget build(BuildContext context) {
    final TaskDetailsStyle style = AppTheme.of(context).taskDetailsStyle;
    return Container(
      width: context.width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(12.r), topEnd: Radius.circular(12.r)),
        color: style.whiteColor,
      ),
      constraints: BoxConstraints(maxHeight: 620.w),
      child: SafeArea(
        child: SmartSingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(mainAxisSize: MainAxisSize.min, children: [_buildHeader(context, style), _buildDetails(style)]),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, TaskDetailsStyle style) {
    return Container(
      color: style.headerBgColor,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w, vertical: 16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SmartText(
                      calendarData.name?.toUpperCamelCase,
                      style: style.headerTitleStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    SmartText(calendarData.categoryName, style: style.headerSubTitleStyle),
                  ],
                ),
              ),
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
    return Row(children: [_buildStatusColumn(style), SizedBox(width: 16.w), _buildPriorityColumn(style, calendarData.priority ?? '')]);
  }

  Widget _buildStatusColumn(TaskDetailsStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SmartText(APPStrings.status.tr, style: style.headerSubTitleStyle),
        Row(
          children: [
            Container(width: 8.w, height: 8.w, decoration: BoxDecoration(color: style.activeColor, shape: BoxShape.circle)),
            SizedBox(width: 8.w),
            SmartText(calendarData.status?.toUpperCamelCase, style: style.statusStyle),
          ],
        ),
      ],
    );
  }

  Widget _buildPriorityColumn(TaskDetailsStyle style, String priority) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SmartText(APPStrings.priority.tr, style: style.headerSubTitleStyle),
        Row(
          children: [
            _buildPriorityIndicator(_getPriorityColor(1, style.activeColor, style.disableColor)),
            _buildPriorityIndicator(_getPriorityColor(2, style.activeColor, style.disableColor)),
            _buildPriorityIndicator(_getPriorityColor(3, style.activeColor, style.disableColor)),
            SizedBox(width: 8.w),
            SmartText(priority.toUpperCamelCase, style: style.statusStyle),
          ],
        ),
      ],
    );
  }

  Widget _buildPriorityIndicator(Color color) {
    return Container(
      width: 5.w,
      height: 17.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(28.r)), color: color),
      margin: EdgeInsetsDirectional.symmetric(horizontal: 2.51.w),
    );
  }

  /// Determines the color for the priority indicator based on the priority level
  Color _getPriorityColor(int position, Color activeColor, Color disableColor) {
    return position <= calendarData.getPriority.intValue ? activeColor : disableColor;
  }

  Widget _buildDetails(TaskDetailsStyle style) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _detailWidget(
                title: APPStrings.startDate.tr,
                subTitle: calendarData.startDate?.changeDateFormat(inputDateFormat: DateFormatter.dateFormatYYYYMMDDTHHMMSSMMMZ) ?? '',
                style: style,
              ),
              SizedBox(width: 32.w),
              _detailWidget(
                title: APPStrings.dueDate.tr,
                subTitle: calendarData.endDate?.changeDateFormat(inputDateFormat: DateFormatter.dateFormatYYYYMMDDTHHMMSSMMMZ) ?? '',
                style: style,
              ),
            ],
          ),
          if (calendarData.assignedToDetails.isNotNullNorEmpty)
            _assignToDetailWidget(assignToDetails: calendarData.assignedToDetails!, style: style),
          _detailWidget(title: APPStrings.description.tr, subTitle: calendarData.description ?? '', style: style),
          _detailWidget(
            title: APPStrings.assignFrom.tr,
            subTitle: calendarData.createdByDetails?.firstname ?? '',
            style: style,
            profileImg: calendarData.createdByDetails?.profilePicUrl?.setMediaUrl,
          ),
          _detailWidget(
            title: APPStrings.createdOn.tr,
            subTitle: calendarData.createdOn?.changeDateFormat(inputDateFormat: DateFormatter.dateFormatYYYYMMDDTHHMMSSMMMZ) ?? '',
            style: style,
          ),
        ],
      ),
    );
  }

  Widget _detailWidget({required String title, required String subTitle, String? profileImg, required TaskDetailsStyle style}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SmartText(title, style: style.headerSubTitleStyle),
        SizedBox(height: 4.h),
        profileImg.isNotNullNorEmpty
            ? Row(
              children: [
                SmartImage(path: profileImg ?? '', height: 24.w, width: 24.w),
                SizedBox(width: 4.w),
                SmartText(subTitle, style: style.userNameStyle),
              ],
            )
            : SmartText(subTitle, style: style.userNameStyle),
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _assignToDetailWidget({required List<UserIdDetails> assignToDetails, required TaskDetailsStyle style}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SmartText(APPStrings.assignTo.tr.toUpperCamelCase, style: style.headerSubTitleStyle),
        SizedBox(height: 4.h),
        ...assignToDetails.map((details) {
          final hasProfilePic = details.profilePicUrl.isNotNullNorEmpty;
          return Padding(
            padding: EdgeInsetsDirectional.only(bottom: 8.h),
            child: Row(
              children: [
                if (hasProfilePic) ...[
                  SmartImage(path: details.profilePicUrl!.setMediaUrl, height: 24.w, width: 24.w),
                  SizedBox(width: 4.w),
                ],
                SmartText(details.fullName, style: style.userNameStyle),
              ],
            ),
          );
        }),
        SizedBox(height: 24.h),
      ],
    );
  }
}
