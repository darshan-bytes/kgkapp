import 'package:kgk/kgk.dart';

class TaskDetailsBottomSheet extends StatelessWidget {
  const TaskDetailsBottomSheet({super.key});

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
                  SmartText("Moodboard Changes", style: style.headerTitleStyle),
                  SizedBox(height: 4.h),
                  SmartText("Category Name", style: style.headerSubTitleStyle),
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
            SmartText("Active", style: style.statusStyle),
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
            SmartText("Low", style: style.statusStyle),
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
              _detailWidget(title: APPStrings.startDate.tr, subTitle: "23 Mar, 2023", style: style),
              SizedBox(width: 32.w),
              _detailWidget(title: APPStrings.dueDate.tr, subTitle: "23 Mar, 2023", style: style),
            ],
          ),
          _detailWidget(
            title: APPStrings.assignTo.tr,
            subTitle: "Jason Smith",
            style: style,
            profileImg: "https://i.ibb.co/SJDj2Pj/Frame-3977.png",
          ),
          _detailWidget(
            title: APPStrings.description.tr,
            subTitle:
                'Lorem ipsum dolor sit amet consectetur. At velit in morbi integer. Nullam suspendisse pulvinar aliquet lacus morbi accumsan. Egestas enim consectetur convallis ut egestas. Volutpat ultrices ullamcorper hendrerit risus',
            style: style,
          ),
          _detailWidget(
            title: APPStrings.assignFrom.tr,
            subTitle: 'Jason Smith',
            style: style,
            profileImg: "https://i.ibb.co/SJDj2Pj/Frame-3977.png",
          ),
          _detailWidget(
            title: APPStrings.createdOn.tr,
            subTitle: "23 Mar, 2023 - 10:00PM",
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
